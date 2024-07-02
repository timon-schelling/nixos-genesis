{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "JetBrainsMono" "SourceCodePro" "Noto" "OpenDyslexic" "RobotoMono"]; })
  ];
}
