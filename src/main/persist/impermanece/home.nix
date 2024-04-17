{ config, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/user/${config.opts.name}/data" = {
    directories = config.opts.user.persist.data.folders;
    files = config.opts.user.persist.data.files;
    allowOther = true;
  };
  home.persistence."/persist/user/${config.opts.name}/state" = {
    directories = config.opts.user.persist.state.folders;
    files = config.opts.user.persist.state.files;
    allowOther = true;
  };
}
