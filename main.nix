{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  utils = import ./utils.nix { inherit lib; };
  imports = utils.collectDirRecursive [
    ./system
    ./user
  ];
in
{
  nixosConfigurations = builtins.trace imports {
    ${opts.host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit utils;
      };
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        {
          inherit imports;
          config = {
            inherit opts;
          };
        }
      ];
    };
  };
}
