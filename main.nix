{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  utils = import ./utils.nix { inherit lib; };
  system = utils.umport { path = ./system; };
  user = utils.umport { path = ./user; };
  imports = system ++ user;
in
{
  nixosConfigurations = {
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
