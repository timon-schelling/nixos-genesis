{ options, ... }:

builtins.trace options {
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  home-manager.users.timon.modules.apps.browser.chromium.enable = true;
  home-manager.users.timon.modules.apps.browser.firefox.enable = true;
  home-manager.users.timon.modules.apps.browser.tor-browser.enable = true;
}
