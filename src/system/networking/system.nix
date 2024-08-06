{ config, lib, pkgs, ... }:

{
  # NetworkManager setup TODO: replace
  # platform.system.persist.folders = [ "/etc/NetworkManager/system-connections" ]; # persistent wifi etc.
  networking = {
    # use iNet Wireless Daemon (instead of wpa_supplicant) for wireless device management
    wireless.iwd = {
      enable = true;

      # All options: https://iwd.wiki.kernel.org/networkconfigurationsettings
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          EnableIPv6 = true;
          RoutePriorityOffset = 300;
        };
        Settings = {
          AutoConnect = true;
          Hidden = true;
          AlwaysRandomizeAddress = false; # for predictable local network
        };
      };
    };

    # networkmanager = {
    #   enable = true;
    #   wifi.backend = "iwd";
    # };

    hostName = config.opts.system.host;
  };

  systemd.network.wait-online.enable = false;
}
