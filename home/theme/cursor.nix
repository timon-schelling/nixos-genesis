{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.oreo-cursors-plus.override {
      cursorsConf = ''
        custom = color: #1c1c1c, stroke: #aaaaaa, stroke-width: 1, stroke-opacity: 1
        sizes = 18
      '';
    };
    name = "custom";
    size = 18;
  };
}
