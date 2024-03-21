{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    qt.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };
}
