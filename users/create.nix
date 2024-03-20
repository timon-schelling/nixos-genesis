{ config, lib, ... }:

{
  users.users = lib.mkMerge (lib.mapAttrsToList
      (name: user: {
        ${name} = {
          isNormalUser = true;
          home = "/home/${name}";
          hashedPassword = user.passwordHash;
          description = user.name;
          extraGroups =
            user.groups ++
            (if user.sudo then [ "wheel" ] else [ ]);
        };
      })
    config.opts.users);
}