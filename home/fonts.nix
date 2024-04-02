{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "NotoSans" "NotoSansMono" "OpenDyslexic" "OpenDyslexicMono" ]; })
  ];
}
