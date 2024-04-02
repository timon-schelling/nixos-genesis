{ pkgs, ... }:

{
  opts.user.state.folders = [
    ".local/share/Enpass"
  ];

  home.packages = [
    pkgs.enpass
  ];
}
