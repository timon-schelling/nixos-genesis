{ config, lib, ... }:

lib.mkMerge (lib.mapAttrsToList
  (name: user: {
    home-manager.users.${name} = {
      programs.git = {
        enable = true;
        userName = .name;
        userEmail = config.opts.users.${user}.email;
      };
    };
  })
  config.opts.users)
