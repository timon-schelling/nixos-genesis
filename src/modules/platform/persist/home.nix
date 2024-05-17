{ lib, ... }:

let
  persistOption = import ./persist-option.nix { inherit lib; };
in
{
  options = {
    platform.user.persist = persistOption;
    opts.user.persist = lib.mkOption {
      type = lib.types.submodule {
        options = {
          data = persistOption;
          state = persistOption;
        };
      };
      default = { };
    };
  };
}
