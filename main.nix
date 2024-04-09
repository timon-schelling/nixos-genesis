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
        inherit lib;
        inherit libutils;
      };
      modules = [
        ./options/main.nix

        (./hosts + "/${host}/config.nix")
        (./hosts + "/${host}/hardware.nix")

        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
        {
          inherit imports;
        }

        ./home.nix
      ];
    };
  };
}
