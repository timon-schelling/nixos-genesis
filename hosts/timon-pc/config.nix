
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
            "dev"
            "data"
            "media"
            "tmp"
          ];
          apps = {
            terminal = {
              rio.enable = true;
              wezterm.enable = true;
            };
            editor = {
              cosmic-edit.enable = true;
              lapce.enable = true;
              vscode.enable = true;
            };
            browser = {
              chromium.enable = true;
              firefox.enable = true;
              tor-browser.enable = true;
            };
            filemanager = {
              gnome.enable = true;
            };
            passwordmanager = {
              enpass.enable = true;
              buttercup.enable = true;
            };
            other = {
              beeper.enable = true;
              discord.enable = true;
              discord-webcord.enable = true;
              spotify.enable = true;
            };
          };
        };
      };
    };
  };

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-amd" ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
}
