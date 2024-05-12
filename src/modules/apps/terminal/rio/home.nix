{ ... }:

{
  programs.rio = {
    enable = true;
    settings = {
      cursor = "|";
      blinking-cursor = false;
      padding-x = 4;
      colors = {
        background = "#1c1c1c";
        foreground = "#aaaaaa";
        cursor = "#aaaaaa";
      };
      fonts = {
        size = 25;
      };
      window.decorations = "Disabled";
    };
  };
}
