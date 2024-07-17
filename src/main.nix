{ inputs, host, ... }:

let
  pkgs = inputs.nixpkgs;
  lib = pkgs.lib.extend (_: _: import ../lib { lib = pkgs.lib; inherit pkgs; });
in
{
  nixosConfigurations = {
    ${host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs lib;
      };
      modules = [

        (../hosts + "/${host}/config.nix")

        {
          imports = (lib.imports.type "system" ./.);
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
