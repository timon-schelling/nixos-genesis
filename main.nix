{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  libutils = import ./utils.nix { inherit lib; };
  imports = libutils.searchModules [
    ./system
    ./users
  ];
in
{
  nixosConfigurations = {
    ${opts.host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit libutils;
      };
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence

        ./options.nix
        {
          inherit imports;
          config = {
            inherit opts;
          };
        }
        (./hosts + "/${opts.host}/hardware.nix")
      ];
    };
  };
}
