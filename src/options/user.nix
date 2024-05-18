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
    persist = lib.mkOption {
      type = lib.types.submodule {
        options = let persistOption = import ./persist.nix { inherit lib; }; in {
          data = persistOption;
          state = persistOption;
        };
      };
      default = { };
    };
    desktops = lib.mkOption {
      type = lib.types.submodule {
        options = {
          hyprhot = lib.mkOption {
            type = lib.types.submodule {
              options = {
                enable = lib.mkOption {
                  type = lib.types.bool;
                  default = false;
                };
              };
            };
            default = { };
          };
        };
      };
      default = { };
    };
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "23.11";
    };
  };
}
