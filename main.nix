{ opts, ... }:

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { inputs, ... }:

    let
      lib = inputs.nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        ${opts.host} = lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            (
              let
                utils = import ./utils.nix { inherit lib; };
                system = utils.umport { path = ./system; };
                user = utils.umport { path = ./user; };
                imports = system ++ user;
              in
              {
                inherit imports;
                config = {
                  inherit opts;
                };
              }
            )
          ];
        };
      };
    };
}
