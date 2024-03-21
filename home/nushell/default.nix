{ config, lib, ... }:

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
          ($nu.config-path | path dirname | path join 'lib')
      ]

      $env.NU_PLUGIN_DIRS = [
          ($nu.config-path | path dirname | path join 'plugins')
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


  starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  xdg.configFile."starship.toml" = {
    source = ./starship.toml;
  };

  carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
