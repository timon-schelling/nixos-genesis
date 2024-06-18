{ lib, ... }:

{
  modules = import ./modules.nix { inherit lib; };
  imports = import ./imports.nix { inherit lib; };
  nuscript = import ./nuscript.nix { inherit lib; };
}
