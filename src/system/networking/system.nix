{ config, lib, pkgs, ... }:

{
  # NetworkManager setup TODO: replace
  # platform.system.persist.folders = [ "/etc/NetworkManager/system-connections" ]; # persistent wifi etc.
  networking = {
    networkmanager = {
      enable = true;
    };
    dhcpcd.enable = false;
    hostName = config.opts.system.host;
  };

  environment.systemPackages = [pkgs.iwgtk];

  systemd.network.wait-online.enable = false;
}
