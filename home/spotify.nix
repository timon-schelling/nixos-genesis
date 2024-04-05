{ pkgs, ... }:

{
  opts.user.state.folders = [
    ".config/spotify"
    ".cache/spotify"
  ];

  home.packages = [
    (pkgs.runCommand "spotify-wayland" { buildInputs = [ pkgs.makeWrapper ]; } ''
      makeWrapper ${pkgs.spotify}/bin/spotify $out/bin/spotify-wayland --enable-features=UseOzonePlatform --ozone-platform=wayland
    '')
  ];
}
