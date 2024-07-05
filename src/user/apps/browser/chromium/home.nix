{ config, lib, pkgs, ... }:

let
  cfg = config.apps.browser.chromium;
in
{
  options.apps.browser.chromium.enable = lib.mkEnableOption "browser chromium";
  config = lib.mkIf cfg.enable {

    platform.user.persist.folders = [
      ".config/chromium"
    ];

    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
