{ config, lib, ... }:

lib.mkMerge (lib.attrsets.attrValues (builtins.mapAttrs
  (name: user:{
    home-manager.users.${name} = {
      programs.git = {
        enable = true;
        userName = user.name;
        userEmail = user.email;
      };
    };
  })
  config.opts.users))
