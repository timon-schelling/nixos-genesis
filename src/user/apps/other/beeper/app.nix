{ pkgs, ... }:

{
  platform.user.persist.folders = [
    ".config/Signal"
  ];

  home.packages = [
    (pkgs.runCommand "signal-custom"
      {
        buildInputs = [ pkgs.makeWrapper ];
      }
      ''
        makeWrapper ${pkgs.signal-desktop}/bin/signal-desktop $out/bin/signal-desktop --set NIXOS_OZONE_WL 1
        cp -r "${pkgs.signal-desktop}/share" "$out/"
      ''
    )
  ];
}
