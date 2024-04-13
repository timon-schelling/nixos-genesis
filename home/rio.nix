{ ... }:

{
  programs.rio = {
    enable = true;
    settings = {
      cursor = "|";
      blinking-cursor = false;
      padding-x = 4;
      window = {
        width = 600;
        height = 400;
        mode = "Windowed";
        foreground-opacity = 1.0;
        background-opacity = 1.0;
        blur = true;
        decorations = "Disabled";
      };
      shell = {
        program = "/usr/bin/env nu";
        args = [];
      };
      fonts = {
        size = 22;
      };
      colors = {
        ackground = "#1c1c1c";
        foreground = "#aaaaaa";
        cursor = "#aaaaaa";
      };
      renderer = {
        performance = "Low";
        backend = "Vukan";
      };
    };
  };
}
