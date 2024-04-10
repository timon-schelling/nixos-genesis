{ inputs, config, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${config.opts.system.platform}.hyprland;
  };

  xdg.portal.wlr.enable = true;

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}