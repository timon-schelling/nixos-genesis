{ config, lib, ... }:

{
  home.persistence."/persist/users/${config.opts.name}" = {
    directories = [
      "dev"
      "data"
      "tmp"
    ];
    allowOther = true;
  };
}
