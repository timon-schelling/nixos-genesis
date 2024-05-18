{ libutils, config, lib, pkgs, ... }:

libutils.modules.mkModule config ./. {}
{
  platform.user.persist.folders = [
    ".config/chromium"
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
