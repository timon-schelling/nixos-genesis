{ config, pkgs, lib, username, ... }:

let
  inherit (import ../../options.nix) username;
in
{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      # "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
        "tmp"
        ".local/share/sddm"
        ".mozilla"
        ".cache"
        ".ssh"
      ];
      files = [
      ];
    };
  };
}
