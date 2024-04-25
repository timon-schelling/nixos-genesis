{ config, pkgs, ... }:

{
  opts.user.persist.state.folders = [

  ];

  home.packages = [
    pkgs.buttercup-desktop
  ];
}
