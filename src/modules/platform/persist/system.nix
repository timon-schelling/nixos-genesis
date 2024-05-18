{ lib, ... }:

{
  options = {
    platform.system.persist = import ./persist-option.nix { inherit lib; };
  };
}
