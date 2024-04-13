{ pkgs, ... }:

{
  opts.user.persist.state.folders = [
    ".config/Beeper"
  ];

  home.packages = [
    (pkgs.runCommand "beeper-custom"
      {
        buildInputs = [ pkgs.makeWrapper ];
      }
      ''
        makeWrapper ${pkgs.beeper}/bin/beeper $out/bin/beeper --set NIXOS_OZONE_WL 1 --add-flags "--default-frame"
        mkdir -p "$out/share/applications/"
        cp "${pkgs.beeper}/share/applications/beeper.desktop" "$out/share/applications/"
      ''
    )
  ];
}
