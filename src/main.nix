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
          imports = (lib.imports.type "system" ./.);
          inherit opts;
        }

        {
          opts.system.host = "${host}";
        }

        ./users.nix

        {
          nixpkgs.overlays = (map (e: import e inputs) (lib.imports.type "overlay" ../overlays));
        }
      ];
    };
  };
}
