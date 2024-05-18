{ lib, ... }:

{
  options = {
    platform.user.persist = import ./persist-option.nix { inherit lib; };
  };
}
