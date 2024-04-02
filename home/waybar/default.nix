{ pkgs, ... }:

{
  home.packages = [
    pkgs.waybar
  ];

  xdg.configFile."waybar/config".source = ./config.json;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
