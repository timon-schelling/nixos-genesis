{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "i2c-dev" "ddcci_backlight" ];
    extraModulePackages = [
      (pkgs.linuxKernel.packages.linux_latest_libre.ddcci-driver.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab {
          owner = "ddcci-driver-linux";
          repo = "ddcci-driver-linux";
          rev = "7853cbfc28bc62e87db79f612568b25315397dd0";
          hash = "sha256-QImfvYzMqyrRGyrS6I7ERYmteaTijd8ZRnC6+bA9OyM=";
        };
        patches = [];
        postInstall = ''
          mv $out/lib/modules/6.10.3-gnu $out/lib/modules/6.10.3
        '';
      }))
    ];
  };
  # security.lockKernelModules = true;
}
