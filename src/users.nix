{ lib, pkgs, inputs, config, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  options = {
    opts.users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          passwordHash = lib.mkOption {
            type = lib.types.str;
          };
          admin = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          groups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
          };
          home = lib.mkOption {
            type = lib.types.anything;
          };
        };
      });
      default = {};
    };
  };

  config = {
    users.users = lib.mkMerge (lib.mapAttrsToList
      (name: user: {
        ${name} = {
          isNormalUser = true;
          home = "/home/${name}";
          hashedPassword = user.passwordHash;
          description = user.name;
          extraGroups = user.groups ++ (if user.admin then [ "admin" ] else [ ]);
          shell = pkgs.nushell;
        };
      })
      config.opts.users
    );
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
        lib = (lib.extend (_: _: inputs.home-manager.lib));
      };
      users = lib.mkMerge (lib.mapAttrsToList
        (username: user:
          let
            opts = {
              system = config.opts.system;
              inherit username;
              user = user.home;
            };
            # TODO: remove
            # systemLib = lib;
          in
          {
            ${username} = { lib, ...}: {
              imports = [
                ./options/home.nix
              ] ++ (lib.import.type "home" ./.);

              options = {
                opts.system = lib.mkOption {
                  type = lib.types.anything;
                };
              };

              config = {
                inherit opts;
              };
            };
          }
        )
        config.opts.users
      );
    };
  };
}