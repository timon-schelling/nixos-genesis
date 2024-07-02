inputs: self: super: {
  hyprland = inputs.hyprland.packages.${super.system}.hyprland;
}
