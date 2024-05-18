{ pkgs, ... }:

{
  platform.user.persist.state.files = [
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

  home.packages = with pkgs; [
    bat
    tere
    fd
    ripgrep
    skim
  ];

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = (builtins.fromTOML (builtins.readFile ./starship.toml));
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
