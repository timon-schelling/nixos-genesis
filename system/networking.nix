{ config, ... }:

{
  networking = {
    useDHCP = true;
    hostName = config.opts.system.host;
    networkmanager.enable = true;
  };
}
