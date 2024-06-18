{ lib, config, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      libutil = lib.util;
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
            ] ++ (lib.util.imports.homeModules ./modules);
            inherit opts;
          };
        }
      )
      config.opts.users);
  };
}
