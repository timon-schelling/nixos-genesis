{ config, lib, ... }:

{
  xdg.configFile."eww" = {
    source = ./config;
    recursive = true;
  };

  programs.eww = {
    enabled = true;
  }
}
