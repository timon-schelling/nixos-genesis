{ config, lib, ... }:

{
  programs.eww = {
    enabled = true;
  };

  xdg.configFile."eww" = {
    source = ./config;
    recursive = true;
  };
}
