{ lib, ... }: {
  options = {
    opts.user = {
      name = lib.mkOption {
        type = lib.types.string;
      };
      email = lib.mkOption {
        type = lib.types.string;
      };
    };
  };
}
