{ config, pkgs, ... }:

{
  platform.user.persist.state.folders = [

  ];

  home.packages = [
    pkgs.buttercup-desktop
  ];
}
