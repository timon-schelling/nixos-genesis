{ pkgs, ... }:

let
  nerdfonts = [
    "FiraCode"
    "FiraMono"
    "JetBrainsMono"
    "SourceCodePro"
    "Noto"
    "OpenDyslexic"
    "RobotoMono"
    "NerdFontsSymbolsOnly"
  ];
in
{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = nerdfonts; })
    pkgs.chrysanthi-unicode-font
  ];
}
