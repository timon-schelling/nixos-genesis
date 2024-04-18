{ inputs, host, ... }:

let
  lib = inputs.nixpkgs.lib;
  libutils = import ./utils.nix { inherit lib; };
  imports = libutils.imports.searchHomeModules [
    ./modules
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
        ../options/main.nix

        (./hosts + "/${host}/config.nix")
        (./hosts + "/${host}/hardware.nix")
        {
          inherit imports;
        }

        ./home.nix
      ];
    };
  };
}
