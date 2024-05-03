{ pkgs, ... }:

{
  opts.user.persist.state.folders = [
    ".config/chromium"
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
