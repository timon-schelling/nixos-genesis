{ config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = config.opts.platform;
}
