{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { inputs, ... }: {};
  # outputs = { inputs, ... }:
  #   let
  #     opts = import ./opts.nix;
  #     base = import ../../main.nix;
  #   in base { inherit inputs; inherit opts; };
}
