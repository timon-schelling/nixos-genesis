{ config, lib, pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    envFile.text = ''
      $env.ENV_CONVERSIONS = {
        "PATH": {
          from_string: { |s| $s | split row (char esep) | path expand -n }
          to_string: { |v| $v | path expand -n | str join (char esep) }
        }
      }

      $env.NU_LIB_DIRS = [
          $"($env.HOME)/.config/nushell/lib"
      ]

      $env.NU_PLUGIN_DIRS = [
          $"($env.HOME)/.config/nushell/plugins"
      ]
    '';
    configFile.text = ''
      source lib.nu
    '';
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
  ];
  # TODO: add persistence for tere via ~/.cache/tere/history.json

}