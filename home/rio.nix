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
        background-opacity = 0.8;
        blur = true;
        decorations = "Disabled";
      };
      shell = {
        program = "nu";
        args = [];
      };
      fonts = {
        size = 22;
      };
    };
  };
}
