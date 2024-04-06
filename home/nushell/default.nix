{ pkgs, ... }:

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

  home.packages = [
    pkgs.tere
    pkgs.skim
    pkgs.bat
    pkgs.ripgrep
  ];

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
}
