{ config, ... }:

{
  networking = {
    hostName = config.opts.system.host;
    networkmanager.enable = true;
  };
}
