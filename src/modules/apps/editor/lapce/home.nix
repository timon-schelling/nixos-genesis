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
in {
  # TODO: configure lapce
  home.packages = [
    pkgs.lapce
  ];

  xdg =
    let
      appName = "lapce-stable";
      toml = pkgs.formats.toml { };
    in {
      configFile = {
        "${appName}/settings.toml".source =
          toml.generate "settings.toml" settings;
        "${appName}/keybindings.toml".source =
          toml.generate "keybindings.toml" keybindings;
      };
      dataFile = {
        "${appName}/plugins".source = ./plugins;
        "${appName}/themes".source = ./themes;
      };
    };
}
