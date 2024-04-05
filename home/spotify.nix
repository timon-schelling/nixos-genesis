{ pkgs, ... }:

{
  opts.user.state.folders = [
    ".config/spotify"
    ".cache/spotify"
  ];

  home.packages = [
    pkgs.spotify
  ];
}
