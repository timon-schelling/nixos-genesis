{ pkgs, ... }:

{
  home.packages = [
    pkgs.gnome.nautilus
    pkgs.gnome.file-roller
  ];
}
