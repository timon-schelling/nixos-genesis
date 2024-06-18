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
    };
    users = lib.mkMerge (lib.mapAttrsToList
      (username: user:
        let
          opts = {
            system = config.opts.system;
            inherit username;
            inherit user;
          };
          systemLib = lib;
        in
        {
          ${username} = { lib, ...}: {
            _module.args = {
              lib = lib // { util = systemLib.util; };
            };
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
