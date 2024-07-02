{ lib, ... }: {
  options = {
    opts.user.name = lib.mkOption {
      type = lib.types.string;
    };
  };
}
