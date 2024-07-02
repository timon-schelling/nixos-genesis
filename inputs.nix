{
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
  anyrun = {
    url = "github:Kirottu/anyrun";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  hyprland.url = "github:hyprwm/Hyprland";
  waybar = {
    url = "github:Alexays/Waybar";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
