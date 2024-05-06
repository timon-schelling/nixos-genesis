{ pkgs, ... }:

{
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        color = "#161616";
      };
      GTK = {
        theme_name = "adw-gtk3-dark";
        application_prefer_dark_theme = true;
      };
    };
    cageArgs = [ "-s" "-m" "last" ];
  };
}
