{ pkgs, ... }:

{
  opts.user.state.folders = [
    ".config/spotify"
  ];

  home.packages = [
    pkgs.spotify
  ];
}
