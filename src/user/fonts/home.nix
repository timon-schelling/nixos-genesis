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
    "DejaVuSansMono"
    "NerdFontsSymbolsOnly"
  ];
in
{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = nerdfonts; })
    (pkgs.dejavu_fonts)
  ];
}
