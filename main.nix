{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  utils = import ./utils.nix { inherit lib; };
  imports = utils.searchModules [
    ./system
    # ./user
  ];
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

        ./options.nix
        {
          inherit imports;
          inherit opts;
        }
      ];
    };
  };
}
