{ config, ... }:

{
  networking.hostName = config.opts.system.host;

  systemd.network = {
    ebable = true;

    netdevs."bridge".netdevConfig = {
      Kind = "bridge";
      Name = "bridge";
    };
    networks."bridge" = {
      matchConfig.Name = "bridge";
      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };
      addresses = [
        {
          addressConfig.Address = "10.0.0.1/24";
        }
        {
          addressConfig.Address = "fd00:0:0:766d::1/64";
        }
      ];
      ipv6Prefixes = [
        {
          ipv6PrefixConfig.Prefix = "fd00:0:0:766d::/64";
        }
      ];
    };
  };

  # Allow inbound traffic for the DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];
}
