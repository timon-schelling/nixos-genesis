{ pkgs, ... }:

let
  settings = {
    core = {
      custom-titlebar = false;
      color-theme = "Black Iris";
      icon-theme = "Material Icons";
    };
    editor = {
      font-family = "FiraCode Nerd Bold Font, monospace";
      font-size = 20;
      tab-width = 2;
      cursor-surrounding-lines = 4;
      render-whitespace = "all";
      bracket-pair-colorization = true;
      highlight-matching-brackets = true;
    };
    ui = {
      font-size = 18;
    };
    lapce-nix = {
      lsp-path = "${pkgs.nil}/bin/nil";
    };
  };
  keybindings = {};
  toml = pkgs.formats.toml { };
in {
  # TODO: configure lapce
  home.packages = [
    pkgs.lapce
  ];

  xdg.configFile."lapce/settings.toml".source =
    toml.generate "settings.toml" settings;

  xdg.configFile."lapce/keybindings.toml".source =
    toml.generate "keybindings.toml" keybindings;

  xdg.dataFile."lapce/plugins".source = ./plugins;

  xdg.dataFile."lapce/themes".source = ./themes;
}
