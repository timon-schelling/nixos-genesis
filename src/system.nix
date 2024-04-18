{ inputs, host, ... }:

let
  lib = inputs.nixpkgs.lib;
  libutils = import ./utils/lib.nix { inherit lib; };
  opts = (import (../hosts + "/${host}/config.nix")).opts;
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

        (../hosts + "/${host}/hardware.nix")

        {
          imports = libutils.imports.systemModules {
            dir = ./modules;
            inherit opts;
          };
        }

        ./home.nix
      ];
    };
  };
}
