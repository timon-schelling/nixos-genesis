inputs: self: super: {
  hyprland = inputs.hyprland.packages.${super.target}.hyprland;
}
