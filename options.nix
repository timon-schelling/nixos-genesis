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
  };
  opts = lib.mkMerge [
    systemOpts
    {
      users = lib.types.attrsOf lib.types.submodule { options = userOpts; };
    }
  ];
in {
  options = {
    opts = lib.mkOption {
      type = lib.types.submodule {
        options = opts;
      };
    };
  };
}
