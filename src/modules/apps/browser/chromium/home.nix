{ pkgs, ... }:

{
  opts.user.persist.state.folders = [
    ".mozilla/firefox/main"
    # ".cache/mozilla"
  ];

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };
}
