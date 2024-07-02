{ lib, ... }: lib.mkOption {
  type = lib.types.submodule {
    options = {
      folders = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
      files = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
      };
    };
  };
  default = { };
}
