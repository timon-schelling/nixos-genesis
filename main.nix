{ inputs, host, ... }:

let
  lib = inputs.nixpkgs.lib;
  pkgs = inputs.nixpkgs.pkgs;
  libutils = import ./utils.nix { inherit lib; inherit pkgs; };
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
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence

        ./options/main.nix
        {
          inherit imports;
        }

        ./home.nix

        (./hosts + "/${host}/config.nix")
        (./hosts + "/${host}/hardware.nix")
      ];
    };
  };
}
