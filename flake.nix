{
  inputs = {
    nixpkgs.url = "git+https://github.com/nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "git+https://github.com/nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "git+https://github.com/nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "git+https://github.com/nix-community/impermanence";
    nix-systems-linux.url = "git+https://github.com/nix-systems/default-linux";
    anyrun = {
      url = "git+https://github.com/Kirottu/anyrun";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "nix-systems-linux";
      };
    };
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.2";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "nix-systems-linux";
      };
    };
    hyprland-plugin-virtual-desktops = {
      url = "git+https://github.com/levnikmyskin/hyprland-virtual-desktops";
      inputs = {
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
      };
    };
    waybar = {
      url = "git+https://github.com/Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = _: {};
}
