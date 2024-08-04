{ config, lib, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      wifi.scanRandMacAddress = false;
    };
    hostName = config.opts.system.host;
    # useNetworkd = true;
  };
  systemd.network.wait-online.enable = false;
}
