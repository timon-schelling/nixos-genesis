{ config, ... }:

let
  driverPkg = config.boot.kernelPackages.nvidiaPackages.beta;
in
{
  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "nvidia_drm" "modeset=1" "fbdev=1" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = driverPkg;
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    package = driverPkg;
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
