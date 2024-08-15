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
    "DejaVu"
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
