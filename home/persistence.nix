{ config, lib, ... }:

{
  home.persistence."/persist/home/${config.opts.name}" = {
    directories = [
      "dev"
      "data"
      "tmp"
    ];
    allowOther = true;
  };
}
