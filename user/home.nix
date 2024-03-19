{ config, lib, ... }:

lib.mkMerge (lib.mapAttrsToList
  (name: user: {
    users.users.${name} = {
      isNormalUser = true;
      home = "/home/${name}";
      description = ${user.name};
      extraGroups =
        user.groups ++
        (if user.sudo then [ "wheel" ] else [ ]);
    };
  })
  config.opts.users)
