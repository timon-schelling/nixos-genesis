with import <nixpkgs> {};

let
  kernel = let
      linux_sgx_pkg = { fetchgit, buildLinux, ... }:

        buildLinux (rec {
          version = "6.6.32";
          modDirVersion = version;

          src = fetchgit {
            url = "https://chromium.googlesource.com/chromiumos/third_party/kernel/";
            rev = "28f597103698f1d8c65034b7734290f3b239eeb9";
            hash = "sha256-UdGWnIBW+GVzkg5rNRM0nLg6ddlVvz1EDgZp3OvZSJQ=";
          };
          kernelPatches = [];

          extraConfig = ''
            VIRTIO_PCI y
            VIRTIO_BLK y
            VIRTIO_NET y
            DRM_VIRTIO_GPU y
            DEVTMPFS_MOUNT y
            SQUASHFS y

            HW_RANDOM y
            HW_RANDOM_VIRTIO y

            NET_9P y
            9P_FS y
          '';
        });
      linux_sgx = pkgs.callPackage linux_sgx_pkg{};
    in
      linux_sgx;
  # kernel = pkgs.linux_latest;

  login = writeScript "login" ''
    #! ${execline}/bin/execlineb -s0
    unexport !
    ${busybox}/bin/login -p -f root $@
  '';

  makeServicesDir = services: with lib;
    let
      services' = {

        ".s6-svscan" = {
          finish = writeScript "init-stage3" ''
            #! ${execline}/bin/execlineb -P
            foreground { s6-nuke -th }
            s6-sleep -m -- 2000
            foreground { s6-nuke -k }
            wait { }
            s6-linux-init-hpr -fr
          '';
        } // services.".s6-svscan" or {};
      } // services;

    in
      runCommandNoCC "services" {} ''
        mkdir $out
        ${concatStrings (mapAttrsToList (name: attrs: ''
          mkdir $out/${name}
          ${concatStrings (mapAttrsToList (key: value: ''
            cp ${value} $out/${name}/${key}
          '') attrs)}
        '') services')}
      '';

  makeStage1 = { run ? null, tapFD }: writeScript "init-stage1" ''
    #! ${execline}/bin/execlineb -P
    export PATH ${lib.makeBinPath
      [ s6-linux-init s6-portable-utils s6-linux-utils s6 execline busybox ]}
    ${s6}/bin/s6-setsid -qb --
    umask 022
    if { s6-mount -t tmpfs -o mode=0755 tmpfs /run }
    if { s6-hiercopy /etc/service /run/service }
    emptyenv -p

    background {
      s6-setsid --
      if { s6-mkdir -p /run/user/0 /dev/pts /dev/shm }
      if { s6-mount -t devpts -o gid=4,mode=620 none /dev/pts }
      if { s6-mount -t tmpfs none /dev/shm }
      if { s6-mount -t proc none /proc }

      ${lib.optionalString (run != null) ''
        export XDG_RUNTIME_DIR /run/user/0
        foreground { ${run} }
        importas -i ? ?
        if { s6-echo STATUS: $? }
        s6-svscanctl -6 /run/service
      ''}
    }

    unexport !
    cd /run/service
    s6-svscan
  '';

  passwd = writeText "passwd" ''
    root:x:0:0:System administrator:/:/bin/sh
  '';

  makeRootfs = { services, run ? null, tapFD }: runCommand "rootfs" {} ''
    mkdir $out
    cd $out
    mkdir bin sbin dev etc proc run tmp
    ln -s ${bash}/bin/bash bin/sh
    ln -s ${makeStage1 { inherit run tapFD; }} sbin/init
    cp ${passwd} etc/passwd
    touch etc/login.defs
    cp -r ${makeServicesDir services} etc/service
  '';

  makeRootSquashfs = rootfs: runCommand "root-squashfs" {} ''
    cd ${rootfs}
    (
        grep -v ^${rootfs} ${writeReferencesToFile rootfs}
        printf "%s\n" *
    ) \
        | xargs tar -cP --owner root:0 --group root:0 --hard-dereference \
        | ${squashfs-tools-ng}/bin/tar2sqfs $out
  '';

  makeVM =
    { name, services ? {}, run ? null, wayland ? false, tapFD ? null }:
    let
      rootfs = makeRootfs { inherit run services tapFD; };
    in writeShellScript name ''
      exec ${crosvm}/bin/crosvm run \
          ${lib.optionalString wayland
              "--wayland-sock $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"} \
          -p init=/sbin/init \
          -b "${makeRootSquashfs rootfs},root,ro" \
          --gpu=context-types=cross-domain:virgl2,backend=2d \
          --disable-sandbox \
          ${kernel}/bzImage
    '';
in

makeVM {
  name = "wayland-vm";
  services.getty.run = writeScript "getty-run" ''
    #! ${execline}/bin/execlineb -P
    ${busybox}/bin/getty -i -n -l ${login} 38400 ttyS0
  '';
  # run = ''
  #   foreground {
  #     ${sommelier}/bin/sommelier --virtgpu-channel ${rio}/bin/rio
  #   }
  #   bash
  # '';
  run = ''
    background {
      ${wayland-proxy-virtwl}/bin/wayland-proxy-virtwl --virtio-gpu --tag="[my-vm] " --wayland-display wayland-0 --x-display=0 --xrdb Xft.dpi:150
    }
    foreground {
      export WAYLAND_DISPLAY wayland-0
      ${wezterm}/bin/wezterm
    }
    foreground {
      ${bash}/bin/bash
    }
    foreground {
      poweroff -f
    }
  '';
  # boot.kernelModules = [ "virtio_pci" "virtio_blk" "virtio_net" "drm_virtio_gpu" "devtmpfs" "squashfs" "hw_random" "hw_random_virtio" "net_9p" "9p_fs" ];
  wayland = true;
  tapFD = 4;
}
