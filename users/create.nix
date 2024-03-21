{ config, lib, pkgs ... }:

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
          shell = pkgs.nushell;
        };
      })
    config.opts.users);
}
