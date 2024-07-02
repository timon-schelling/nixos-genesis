{ inputs, host, ... }:

let
  lib = inputs.nixpkgs.lib;
  util = import ./util/lib.nix { inherit lib; };
  opts = import (../hosts + "/${host}/config.nix");
in
{
  nixosConfigurations = {
    ${host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        lib = lib // { inherit util; };
        inherit opts;
      };
      modules = [
        ./options/main.nix

        (../hosts + "/${host}/hardware.nix")

        {
          imports = (util.imports.systemModules ./modules);
          inherit opts;
        }

        ./home.nix

        {
          nixpkgs.overlays = (map (e: import e) (util.imports.overlays ./overlays));
        }
      ];
    };
  };
}
