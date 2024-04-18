{ inputs, host, ... }:

let
  lib = inputs.nixpkgs.lib;
  libutils = import ./utils/lib.nix { inherit lib; };
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

        (../hosts + "/${host}/config.nix")
        (../hosts + "/${host}/hardware.nix")
        ({ config, ... }: {
          imports = builtins.trace (libutils.imports.systemModules {
            dir = ./modules;
            opts = config.opts;
          })
          (libutils.imports.systemModules {
            dir = ./modules;
            opts = config.opts;
          });
        })

        ./home.nix
      ];
    };
  };
}
