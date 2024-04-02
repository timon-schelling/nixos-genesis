{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "SourceCodePro" "Noto" "OpenDyslexic" "RobotoMono"]; })
  ];
}
