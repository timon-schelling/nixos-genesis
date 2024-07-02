{ inputs, host, ... }:

let
  pkgs = inputs.nixpkgs;
  lib = pkgs.lib // import ../lib { lib = pkgs.lib; inherit pkgs; };
  opts = import (../hosts + "/${host}/config.nix");
in
{
  nixosConfigurations = {
    ${host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs lib;
      };
      modules = [

        (../hosts + "/${host}/hardware.nix")

        {
          imports = (lib.import.type "system" ./.);
          inherit opts;
        }

        ./users.nix

        {
          # nixpkgs.overlays = (map (e: import e) (lib.import.type "overlay" ../overlays));
        }
      ];
    };
  };
}
