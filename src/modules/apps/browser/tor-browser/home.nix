{ libutils, config, lib, pkgs, ... }:

libutils.modules.mkModule config ./. {}
{
  home.packages = [
    pkgs.tor-browser
  ];
}
