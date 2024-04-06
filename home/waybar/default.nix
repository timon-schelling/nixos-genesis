{ pkgs, libutils, ... }:

{
  home.packages = [
    pkgs.waybar
    (libutils.mkNuScript pkgs "waybar-toggle" ''
      let waybar_pids = (ps | filter { |e| $e.name | str contains -i waybar }).pid
      if ($waybar_pids | is-empty) {
        hyprctl dispatch exec waybar
      } else {
        $waybar_pids | each { |pid| kill $pid }
      }
    '')
  ];

  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
