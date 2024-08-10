{ pkgs, ... }:

{
  opts = {
    system = {
      drive = "/dev/nvme1n1";
      platform = "x86_64-linux";
    };
    users = {
      timon = {
        passwordHash = "$6$rounds=262144$btdA4Fl2MtXbCcEw$wzDDnSCaBlgUYNIXQm0fK8dKjHQAPFP6AiQz6qpZi3l9/h69WmbMAhSNtPYN5qSGcEw4yJGQT4W0KdPFvAcYg0";
        admin = true;
        home = {
          name = "Timon Schelling";
          email = "me@timon.zip";
          persist.data.folders = [
            "code"
            "data"
            "media"
            "tmp"
          ];
          profile = "personal";
        };
      };
    };
  };

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    extraModulePackages = [
      (pkgs.linuxKernel.packages.linux_latest_libre.ddcci-driver.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab {
          owner = "ddcci-driver-linux";
          repo = "ddcci-driver-linux";
          rev = "7853cbfc28bc62e87db79f612568b25315397dd0";
          hash = "sha256-QImfvYzMqyrRGyrS6I7ERYmteaTijd8ZRnC6+bA9OyM=";
        };
      }))
    ];
    kernelModules = [ "kvm-amd" "i2c-dev" "ddcci_backlight" ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  # disable the tpm module because is not supported and causes failures during boot
  boot.blacklistedKernelModules = [ "tpm" "tpm_atmel" "tpm_infineon" "tpm_nsc" "tpm_tis" "tpm_crb" ];
}
