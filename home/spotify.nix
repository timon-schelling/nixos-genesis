{ pkgs, ... }:

{
  opts.user.state.folders = [
    ".config/spotify"
    ".cache/spotify"
  ];

  home.packages = [
    (pkgs.spotify.override {
      deviceScaleFactor = "1 --enable-features=UseOzonePlatform --ozone-platform=wayland";
    })
  ];
}
