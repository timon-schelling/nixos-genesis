{ config, ... }:

{
  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta_vulkan;
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
}
