{ config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = config.opts.system.platform;
}
