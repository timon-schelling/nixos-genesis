{ lib, libutils, config, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = lib.mkMerge (lib.mapAttrsToList
      (name: user: {
        ${name} = { ... }: {
          _module.args = {
            username = name;
            inherit user;
          };
          imports = libutils.searchModules [
            "./home"
          ];
        };
      })
      config.opts.users);
  };
}
