{ lib, libutils, config, options, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  options = {
    # opts.users = lib.mkOption {
    #   type = lib.types.attrsOf (options.home-manager.users.type.functor.wrapped);
    # };
    opts.users = lib.mkAliasDefinitions (options.home-manager.users or {});
  };
  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
        inherit libutils;
      };
      users = lib.mkMerge (lib.mapAttrsToList
        (username: user:
          let
            opts = {
              system = config.opts.system;
              inherit username;
              inherit user;
            };
          in
          {
            ${username} = {
              imports = [
                ./options/home.nix
              ] ++ (libutils.imports.homeModules {
                dir = ./modules;
                inherit opts;
              });
              inherit opts;
            };
          }
        )
        config.opts.users);
    };
  };
}
