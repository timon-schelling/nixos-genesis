{ config, lib, ... }:

{
  home.persistence."/persist/user/${config.opts.name}/home" = {
    directories = config.opts.user.persist.folders;
    files = config.opts.user.persist.files;
    allowOther = true;
  };
}
