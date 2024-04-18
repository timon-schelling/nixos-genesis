{ inputs, host, ... }:

let
  lib = inputs.nixpkgs.lib;
  libutils = import ./utils.nix { inherit lib; };
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
        ../options/main.nix

        (./hosts + "/${host}/config.nix")
        (./hosts + "/${host}/hardware.nix")
        ({ config, ... }: {
          imports = libutils.imports.systemModules {
            dir = ./modules;
            opts = config.opts;
          };
        })

        ./home.nix
      ];
    };
  };
}
