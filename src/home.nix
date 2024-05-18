{ lib, libutils, config, options, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  options = {
    tmp = builtins.trace options.home-manager.users.type.functor.wrapped;
    opts.users = options.tmp;
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
