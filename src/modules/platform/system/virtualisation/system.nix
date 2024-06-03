{ ... }:

{
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
}
