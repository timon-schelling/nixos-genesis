{ config, lib, pkgs, ... }:

{
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };

  systemd.services.createPersistUsersDir = {
    description = "Create /persist/user directory with 1777 permissions for Home Manager Impermanence";
    requiredBy = [ "multi-user.target" ];
    after = [ "basic.target" ];
    before = [ "graphical-session-pre.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.coreutils}/bin/mkdir -p /persist/user && ${pkgs.coreutils}/bin/chmod 1777 /persist/user";
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
      Group = "root";
    };
  };
}
