{ pkgs, ... }:

{
  home.packages = [ pkgs.eww ];

  xdg.configFile."eww" = {
    source = ./config;
    recursive = true;
  };
}
