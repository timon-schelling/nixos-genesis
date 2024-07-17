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
    anyrun = {
      url = "git+https://github.com/Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.2";
    hyprland-plugin-virtual-desktops = {
      url = "git+https://github.com/levnikmyskin/hyprland-virtual-desktops";
      inputs.hyprland.follows = "hyprland";
    };
    waybar = {
      url = "git+https://github.com/Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = i: import ../../outputs.nix i (builtins.baseNameOf ./.);
}
