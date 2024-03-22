{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.oreo-cursors-plus.overwrite {
      cursorsConf = ''
        sizes = 8, 10, 12, 14, 16, 18, 20, 24, 32, 40, 48, 56, 64
        custom = color: #000, stroke: #fff, stroke-width: 1, stroke-opacity: 1
      '';
    };
    name = "custom";
    size = 18;
  };
}
