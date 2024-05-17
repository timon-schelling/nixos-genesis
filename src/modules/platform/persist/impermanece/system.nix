{ config, inputs, pkgs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = config.platform.system.persist.folders ++ config.opts.system.persist.folders;
    files = config.platform.system.persist.files ++ config.opts.system.persist.folders;
  };

  systemd.services."create-persist-user-dir" = {
    description = "Create /persist/user directory for Home Manager Impermanence with 1777 permissions";
    requiredBy = [ "multi-user.target" ];
    after = [ "basic.target" ];
    before = [ "graphical-session-pre.target" ];
    script = ''
      ${pkgs.coreutils}/bin/mkdir -p /persist/user
      ${pkgs.coreutils}/bin/chmod 1777 /persist/user
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
      Group = "root";
    };
  };

  programs.fuse.userAllowOther = true;
}
