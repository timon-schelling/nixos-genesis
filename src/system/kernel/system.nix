{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "i2c-dev" "ddcci_backlight" ];
    extraModulePackages = [
      (pkgs.linuxPackages_latest.ddcci-driver.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab {
          owner = "ddcci-driver-linux";
          repo = "ddcci-driver-linux";
          rev = "7853cbfc28bc62e87db79f612568b25315397dd0";
          hash = "sha256-QImfvYzMqyrRGyrS6I7ERYmteaTijd8ZRnC6+bA9OyM=";
        };
        patches = [];
      }))
    ];
  };
  # security.lockKernelModules = true;
}
