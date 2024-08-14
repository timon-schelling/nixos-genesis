{  pkgs, lib, ... }:

{
  home.packages = [
    pkgs.brightnessctl
    (pkgs.nu.writeScriptBin "monitor-set-brightness" ''
      def --wrapped main [...args] {
        try { monitor-fix-ddcci-nvidia }
        ls /sys/class/backlight | get name | path basename | par-each {
          ${pkgs.brightnessctl}/bin/brightnessctl --device $in set ...$args
        }
      }
    '')
  ];
}
