{ pkgs, ... }:

{
  home.packages = [
    pkgs.waybar
  ];

  xdg.configFile.".config/waybar/config".source = ./config.json;
  xdg.configFile.".config/waybar/style.css".source = ./style.css;
}
