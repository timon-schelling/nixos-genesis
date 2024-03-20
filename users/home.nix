{ lib, libutils, config, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = lib.mkMerge (lib.mapAttrsToList
      (name: user: {
        ${name} = { ... }: {
          imports = [
            ../options.nix
            ../home/state-version.nix
          ];
          config = {
            _module.args = {
              username = name;
              inherit user;
            };
            opts = config.opts;
          };
        };
      })
      config.opts.users);
  };
}
