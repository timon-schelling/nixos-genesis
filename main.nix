{ inputs, host, ... }:

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
    ${host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit libutils;
      };
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence

        ./options/main.nix
        {
          inherit imports;
          config = {
            inherit opts;
          };
        }

        ./home.nix

        (./hosts + "/${host}/config.nix")
        (./hosts + "/${host}/hardware.nix")
      ];
    };
  };
}
