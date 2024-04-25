{ pkgs, ... }:

{
  opts.user.persist.state.folders = [
    ".config/discord"
  ];

  home.packages = [
    (pkgs.runCommand "discord-custom"
      {
        buildInputs = [ pkgs.makeWrapper ];
      }
      ''
        makeWrapper ${pkgs.beeper}/bin/Discord $out/bin/Discord --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
        cp -r "${pkgs.beeper}/share" "$out/"
      ''
    )
  ];
}
