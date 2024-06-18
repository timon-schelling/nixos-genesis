{ lib, ... }:

{
  options = {
    opts = lib.mkOption {
      type = lib.types.submodule {
        options = {
          system = lib.mkOption {
            type = lib.types.anything;
            default = {};
          };
          username = lib.mkOption {
            type = lib.types.str;
          };
          user = lib.mkOption {
            type = lib.types.anything;
            default = {};
          };
        };
      };
      default = {};
    };
  };
}
