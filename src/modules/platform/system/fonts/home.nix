{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "SourceCodePro" "JetBrainsMono" "Noto" "OpenDyslexic" "RobotoMono"]; })
  ];
}
