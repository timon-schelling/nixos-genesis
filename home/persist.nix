{ config, lib, ... }:

{
  home.persistence."/persist/user/${config.opts.name}/home" = {
    directories = [
      "dev"
      "data"
      "tmp"
    ];
    allowOther = true;
  };
}
