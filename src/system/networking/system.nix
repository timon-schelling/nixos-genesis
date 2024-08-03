{ config, lib, ... }:

{
  platform.system.persist.folders = [ "/etc/NetworkManager/system-connections" ];
  networking = {
    networkmanager = {
      enable = true;
      wifi.scanRandMacAddress = false;
    };
    hostName = config.opts.system.host;
    useNetworkd = true;
    usePredictableInterfaceNames = true;
  #   networking.bridges = {
  #     "host" = {
  #       interfaces = [
  #         "lan"
  #       ];
  #     };
  #     "vms" = {
  #       interfaces = [
  #         "host"
  #       ];
  #     };
  #   };
  # };


  # systemd.network = {
  #   enable = true;

  #   hostName = config.opts.system.host;

  #   netdevs."bridge".netdevConfig = {
  #     Kind = "bridge";
  #     Name = "bridge";
  #   };
  #   networks."bridge" = {
  #     matchConfig.Name = "bridge";
  #     networkConfig = {
  #       DHCPServer = true;
  #       IPv6SendRA = true;
  #     };
  #     addresses = [
  #       {
  #         addressConfig.Address = "10.0.0.1/24";
  #       }
  #       {
  #         addressConfig.Address = "fd00:0:0:766d::1/64";
  #       }
  #     ];
  #     ipv6Prefixes = [
  #       {
  #         ipv6PrefixConfig.Prefix = "fd00:0:0:766d::/64";
  #       }
  #     ];
  #   };
  # };

    # Allow inbound traffic for the DHCP server
    # firewall.allowedUDPPorts = [ 67 ];
  };

  # systemd = {
  #   targets.network-online.wantedBy = lib.mkForce []; # Normally ["multi-user.target"]
  #   services.NetworkManager-wait-online.wantedBy = lib.mkForce []; # Normally ["network-online.target"]
  # };
}
