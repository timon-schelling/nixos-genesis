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
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          primary = mkOption {
            type = types.bool;
            default = false;
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
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
