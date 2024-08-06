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
          NameResolvingService = "systemd";
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

  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };

  systemd.network.wait-online.enable = false;
}
