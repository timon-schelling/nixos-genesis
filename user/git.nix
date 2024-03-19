{ config, lib, ... }:

{
  home-manager.users = lib.mkMerge (lib.mapAttrsToList
    (name: user:{
      ${name} = {
        programs.git = {
          enable = true;
          userName = user.name;
          userEmail = user.email;
        };
      };
    })
    config.opts.users);
}
