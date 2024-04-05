{ lib, ... }:

lib.types.submodule {
  options = {
    stateVersion = lib.mkOption {
      type = lib.types.str;
      default = "23.11";
    };
    platform = lib.mkOption {
      type = lib.types.str;
      default = "x86_64-linux";
    };
    drive = lib.mkOption {
      type = lib.types.path;
    };
    host = lib.mkOption {
      type = lib.types.str;
    };
    swap = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          size = lib.mkOption {
            type = lib.types.str;
            default = "32G";
          };
        };
      };
      default = {};
    };
    monitors = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          enabled = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
          name = lib.mkOption {
            type = lib.types.str;
            example = "DP-1";
          };
          primary = lib.mkOption {
            type = lib.types.bool;
            default = false;
          };
          width = lib.mkOption {
            type = lib.types.int;
            example = 1920;
          };
          height = lib.mkOption {
            type = lib.types.int;
            example = 1080;
          };
          x = lib.mkOption {
            type = lib.types.int;
            default = 0;
          };
          y = lib.mkOption {
            type = lib.types.int;
            default = 0;
          };
        };
      });
    };
    persist = lib.mkOption {
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
    };
  };
}