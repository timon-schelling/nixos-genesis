{ config, lib, ... }:

{
  # NetworkManager setup TODO: replace
  # platform.system.persist.folders = [ "/etc/NetworkManager/system-connections" ]; # persistent wifi etc.
  networking = {
      networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
      dhcpcd.enable = false;
      wireless = {
        iwd = {
          enable = true;
          settings = {
            General = {
              EnableNetworkConfiguration = true;
            };
            Settings = {
              AlwaysRandomizeAddress = true;
            };
            Network = {
              EnableIPv6 = false;
            };
          };
        };
      };
    hostName = config.opts.system.host;
  };
  systemd.network.wait-online.enable = false;
}
