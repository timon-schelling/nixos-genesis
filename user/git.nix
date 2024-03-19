{ config, lib, ... }:

lib.mkMerge (lib.mapAttrsToList
  (name: user: {
    home-manager.users.${name} = {
      programs.git = {
        enable = true;
        userName = config.opts.users.${user}.name;
        userEmail = config.opts.users.${user}.email;
      };
    };
  })
  config.opts.users)
