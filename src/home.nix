{ lib, libutils, config, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit libutils;
    };
    users = lib.mkMerge (lib.mapAttrsToList
      (name: user: {
        ${name} = { config, ... }: {
          imports = [
            ./options/home.nix
          ] ++ libutils.imports.systemModules {
            dir = ./modules;
            opts = config.opts;
          };
          config = {
            opts = {
              system = config.opts.system;
              inherit name;
              inherit user;
            };
          };
        };
      })
      config.opts.users);
  };
}
