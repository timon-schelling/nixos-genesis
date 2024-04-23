{ pkgs, ... }:

{
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = "Adwaita";
        font_name = "SourceCodePro Regular 11";
        icon_theme_name = "Papirus";
        theme_name = "Colloid-Dark";
      };
    };
  };
}
