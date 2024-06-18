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
      lib = (lib.extend (_: _: inputs.home-manager.lib)).extend (_: _: { util = lib.util; });
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
            imports = [
              ./options/home.nix
            ] ++ (systemLib.util.imports.homeModules ./modules);
            inherit opts;
          };
        }
      )
      config.opts.users);
  };
}
