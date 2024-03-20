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
          name = lib.mkOption {
            type = lib.types.str;
          };
          user = lib.mkOption {
            type = import ./users.nix { inherit lib; };
            default = {};
          };
        };
      };
    };
  };
}
