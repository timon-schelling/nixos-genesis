{ lib, ... }:

let
  utils = import ./utils.nix { inherit lib; };
  system = utils.umport { path = ./system; };
  user = utils.umport { path = ./user; };
  imports = system ++ user;
in {
  inherit imports;
}
