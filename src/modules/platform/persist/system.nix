{ lib, ... }:

let
  persistOption = import ./persist-option.nix { inherit lib; };
in
{
  options = {
    platform.system.persist = persistOption;
    opts.system.persist = persistOption;
  };
}
