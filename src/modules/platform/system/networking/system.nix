{ config, ... }:

{
  networking.hostName = config.opts.system.host;

  systemd.network = {
    netdevs."10-vms".netdevConfig = {
      Kind = "bridge";
      Name = "vms";
    };
    networks."10-vms" = {
      matchConfig.Name = "vms";
      networkConfig = {
        DHCPServer = true;
        IPv6SendRA = true;
      };
      addresses = [ {
        addressConfig.Address = "10.0.0.1/24";
      } {
        addressConfig.Address = "fd12:3456:789a::1/64";
      } ];
      ipv6Prefixes = [ {
        ipv6PrefixConfig.Prefix = "fd12:3456:789a::/64";
      } ];
    };
  };

  # Allow inbound traffic for the DHCP server
  networking.firewall.allowedUDPPorts = [ 67 ];
}
