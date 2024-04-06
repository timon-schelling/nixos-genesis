{ config, lib, pkgs, ... }:

{
  opts.user.persist.state.files = [
    ".config/nushell/history.txt"
    ".cache/tere/history.json"
  ];

  programs.nushell = {
    enable = true;
    envFile.source = ./env.nu;
    configFile.source = ./config.nu;
  };
  xdg.configFile."nushell/lib" = {
    source = ./lib;
    recursive = true;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };
  xdg.configFile."starship.toml" = {
    source = ./starship.toml;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.packages = [
    pkgs.tere
    pkgs.skim
  ];
}
