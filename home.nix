{ lib, libutils, config, ... }:

let
  modules = libutils.searchModules [
    ./home
  ];
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = lib.mkMerge (lib.mapAttrsToList
      (name: user: {
        ${name} = { ... }: {
          imports = [
            ./options/home.nix
          ] ++ modules;
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
