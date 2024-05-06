{ pkgs, inputs, config, libutils, ... }:

{
  home.packages = [
    (inputs.waybar.packages.${config.opts.system.platform}.waybar)
    (libutils.nuscript.mkScript pkgs "waybar-toggle" (builtins.readFile ./toggle.nu))
  ];

  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
}
