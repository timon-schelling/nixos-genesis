{ config, lib, ... }:

{
  home.persistence."/persist/user/${config.opts.name}/home" = {
    directories = config.opts.user.persist.folders;
    files = config.opts.user.persist.files;
    allowOther = true;
  };
  home.persistence."/persist/user/${config.opts.name}/state" = {
    directories = config.opts.user.state.folders;
    files = config.opts.user.state.files;
    allowOther = true;
  };
}
