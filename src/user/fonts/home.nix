{ pkgs, ... }:

let
  fonts = [
    "FiraCode"
    "FiraMono"
    "JetBrainsMono"
    "SourceCodePro"
    "Noto"
    "OpenDyslexic"
    "RobotoMono"
  ];
in
{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { inherit fonts; })
  ];
}
