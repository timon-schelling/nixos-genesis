{  pkgs, lib, ... }:

{
  home.packages = [
    pkgs.brightnessctl
    (pkgs.nu.writeScriptBin "monitor-set-brightness" ''
      def main [...args] {
        ll /sys/class/backlight | get name | path basename | par-each {
          ${pkgs.brightnessctl} -- --device $in set ...$args
        }
      }
    '')
  ];
}
