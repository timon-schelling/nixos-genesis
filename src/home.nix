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
      (name: user:
        let
          opts = {
            system = config.opts.system;
            inherit name;
            inherit user;
          };
        in
        {
          ${name} = {
            imports = [
              ./options/home.nix
            ] ++ libutils.imports.homeModules {
              dir = ./modules;
              inherit opts;
            };
            config = {
              inherit opts;
            };
          };
        }
      )
      config.opts.users);
  };
}
