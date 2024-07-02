{ lib, ... }:

let
  persist = import ./persist.nix lib;
in
{
  options = {
    opts.system.persist = persist;
    platform.system.persist = persist;
  };
}
