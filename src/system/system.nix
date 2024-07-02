{ lib, ... }:

{
  options = {
    opts.system = {
      platform = lib.mkOption {
        type = lib.types.str;
        default = "x86_64-linux";
      };
      stateVersion = lib.mkOption {
        type = lib.types.str;
        default = "24.05";
      };
    };
  };
}
