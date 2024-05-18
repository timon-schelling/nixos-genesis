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
          username = lib.mkOption {
            type = lib.types.str;
          };
          user = lib.mkOption {
            type = import ./user.nix { inherit lib; };
            default = {};
          };
        };
      };
      default = {};
    };
  };
}
