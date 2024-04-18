{ lib, ... }:

{
  system = opts: (lib.attrsets.filterAttrs (n: v: v.desktops.hyprhot.enable) opts.users) == {};
  home = opts: opts.user.desktops.hyprhot.enable;
}
