{ config, lib, ... }:

{
  home.persistence."/persist/users/${config.opts.name}/home" = {
    directories = [
      "dev"
      "data"
      "tmp"
    ];
    allowOther = true;
  };
}
