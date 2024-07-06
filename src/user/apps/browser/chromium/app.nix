{ config, lib, pkgs, ... }:

{
  platform.user.persist.folders = [
    ".config/chromium"
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
