{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  libhome = inputs.home-manager.lib;
  utils = import ./utils.nix { inherit lib; };
  system = utils.umport { path = ./system; };
  user = utils.umport { path = ./user; };
in
{
  nixosConfigurations = {
    ${opts.host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit utils;
      };
      modules = [
        inputs.nixpkgs.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.default

        {
          imports = system;
          config = {
            inherit opts;
          };
        }
        {
          home-manager.extraSpecialArgs = {
            inherit username; inherit inputs;
            inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) gtkThemeFromScheme;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = import ./home.nix;
        }

      ];
    };
  };
}
