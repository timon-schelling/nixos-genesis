{ pkgs, ... }:

{
  opts.user.persist.state.folders = [
    ".config/spotify"
    ".cache/spotify"
  ];

  home.packages = [
    (pkgs.runCommand "spotify-wayland" { buildInputs = [ pkgs.makeWrapper ]; } ''
      makeWrapper ${pkgs.spotify}/bin/spotify $out/bin/spotify --set ELECTRON_OZONE_PLATFORM_HINT wayland
      mkdir -p "$out/share/applications/"
      cp "${pkgs.spotify}/share/applications/spotify.desktop" "$out/share/applications/"
    '')
  ];
}
