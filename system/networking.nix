{ config, ... }:

{
  networking.hostName = config.opts.system.host;
  networking.networkmanager.enable = true;
  networking.useDHCP = true;
}
