{ lib, ... }:

lib.types.submodule {
  options = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "User";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    passwordHash = lib.mkOption {
      type = lib.types.str;
    };
    sudo = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "23.";
    };
  };
}
