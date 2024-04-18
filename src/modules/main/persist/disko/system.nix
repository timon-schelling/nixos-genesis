{ config, inputs, lib, ... }:

{
  imports = [
    inputs.disko.nixosModules.default
  ];

  disko.devices = {
    disk.main = {
      device = config.opts.system.drive;
      type = "disk";
      content = {
        type = "gpt";
        partitions = lib.mkMerge [
          {
            esp = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "root_vg";
              };
            };
          }
          (lib.mkIf config.opts.system.swap.enable {
            swap = {
              size = config.opts.system.swap.size;
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
          })
        ];
      };
    };
    lvm_vg = {
      root_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                };
                "/persist" = {
                  mountOptions = [ "subvol=persist" "noatime" ];
                  mountpoint = "/persist";
                };
                "/nix" = {
                  mountOptions = [ "subvol=nix" "noatime" ];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  };
}