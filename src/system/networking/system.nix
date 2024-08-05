{ config, lib, ... }:

{
  # NetworkManager setup TODO: replace
  platform.system.persist.folders = [ "/etc/NetworkManager/system-connections" ]; # persistent wifi etc.
  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    # wireless.iwd.enable = true;
    hostName = config.opts.system.host;
  };
  systemd.network.wait-online.enable = false;
}
