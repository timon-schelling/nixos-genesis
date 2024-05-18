{ pkgs, ... }:

{
  platform.user.persist.state.folders = [
    ".config/discord"
  ];

  home.packages = [
    (pkgs.runCommand "discord-custom"
      {
        buildInputs = [ pkgs.makeWrapper ];
      }
      ''
        makeWrapper ${pkgs.discord}/bin/Discord $out/bin/Discord --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
        cp -r "${pkgs.discord}/share" "$out/"
      ''
    )
  ];
}
