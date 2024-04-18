{ lib, ... }:

let
  imports = import ./imports.nix { inherit lib; };
  nuscript = import ./nuscript.nix { inherit lib; };
in
{
  inherit imports;
  inherit nuscript;
}
