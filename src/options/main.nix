{ lib, ... }:

{
  options = {
    opts = lib.mkOption {
      type = lib.types.submodule {
        options = {
          system = lib.mkOption {
            type = import ./system.nix { inherit lib; };
            default = {};
          };
        };
        default = {};
      };
    };
  };
}
