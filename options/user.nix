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
    persist = lib.mkOption {
      type = lib.types.submodule {
        options = {
          data = lib.mkOption {
            type = lib.types.submodule {
              options = {
                folders = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [
                    "dev"
                    "data"
                    "media"
                    "tmp"
                  ];
                };
                files = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [ ];
                };
              };
            };
            default = { };
          };
          state = lib.mkOption {
            type = lib.types.submodule {
              options = {
                folders = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [];
                };
                files = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  default = [ ];
                };
              };
            };
            default = { };
          };
        };
      };
      default = { };
    };
  };
}
