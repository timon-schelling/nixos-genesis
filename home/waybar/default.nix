{ pkgs, libutils, ... }:

{
  home.packages = [
    pkgs.waybar
    (libutils.mkNuScript pkgs "waybar-toggle" builtins.readFile ./toggle.nu)
  ];

  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
