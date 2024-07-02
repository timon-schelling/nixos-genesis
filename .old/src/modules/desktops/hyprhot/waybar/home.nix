{ pkgs, inputs, config, lib, ... }:

{
  home.packages = [
    (inputs.waybar.packages.${config.opts.system.platform}.waybar)
    (lib.util.nuscript.mkScript pkgs "waybar-toggle" (builtins.readFile ./toggle.nu))
  ];

  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
