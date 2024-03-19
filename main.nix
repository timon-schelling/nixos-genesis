{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  libhome = inputs.home-manager.lib;
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
        inputs.nixpkgs.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.default
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
