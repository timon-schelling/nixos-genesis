{ config, lib, ... }:

builtins.trace (lib.mapAttrsToList
  (name: user: {
    home-manager.users.${name} = {
      programs.git = {
        enable = true;
        userName = user.name;
        userEmail = user.email;
      };
    };
  })
  config.opts.users) {}
