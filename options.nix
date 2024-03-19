{ lib, ... }:
let
  systemOpts = {
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
    swap = lib.types.submodule {
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
  };
  userOpts = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "User";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
    sudo = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };
  opts = lib.mkMerge [
    systemOpts
    {
      users = lib.types.attrsOf (lib.types.submodule { options = userOpts; });
    }
  ];
in
{
  options = {
    opts = lib.mkOption {
      type = lib.types.submodule {
        options = opts;
      };
    };
  };
}
