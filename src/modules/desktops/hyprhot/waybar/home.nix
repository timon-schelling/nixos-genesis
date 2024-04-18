{ pkgs, libutils, ... }:

{
  home.packages = [
    pkgs.waybar
    (libutils.nuscript.mkScript pkgs "waybar-toggle" (builtins.readFile ./toggle.nu))
  ];

  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
