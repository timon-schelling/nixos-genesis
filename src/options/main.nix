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
          users = lib.mkOption {
            type = lib.types.attrsOf (import ./user.nix { inherit lib; });
          };
        };
      };
    };
  };
}
