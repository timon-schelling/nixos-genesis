{ lib, ... }: {
  options = {
    opts = {
      username = lib.mkOption {
        type = lib.types.string;
      };
      user = {
        name = lib.mkOption {
          type = lib.types.string;
        };
        email = lib.mkOption {
          type = lib.types.string;
        };
      };
    };
  };
}
