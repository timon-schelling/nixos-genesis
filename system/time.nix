{ ... }:

{
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
}
