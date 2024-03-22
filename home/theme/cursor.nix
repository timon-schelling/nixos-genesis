{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.oreo-cursors-plus.override {
      cursorsConf = ''
        sizes = 12, 14, 16, 18, 20, 24, 32, 40, 48, 56, 64
        test = color: #000, stroke: #fff, stroke-width: 1, stroke-opacity: 1
      '';
    };
    name = "test";
    size = 18;
  };
}
