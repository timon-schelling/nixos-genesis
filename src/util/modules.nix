{ lib, ... }:

let
  anyMapAttrs = filter: attrs: lib.any (x: x) (lib.mapAttrsToList (key: value: filter key value) attrs);

  anyUser = opts: filter: anyMapAttrs filter opts.users;

  mkIfAnyUser = opts: filter: content: lib.mkIf (builtins.trace (anyUser opts filter) (anyUser opts filter)) (lib.mkMerge [content]);

  perUser = opts: function: lib.mkMerge (lib.mapAttrsToList function opts.users);

  perUserHomeManager = opts: function: perUser opts (name: user: {
    home-manager = {
      users = {
        ${name} = (function name user);
      };
    };
  });

  mkOpts = { system ? {}, user ? {} }: {
    opts.system = system;
    opts.users = (mkUserOpt user);
  };

  mkUserOpt = options: lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = options;
    });
    default = {};
  };

  mkSystemOpt = options: lib.mkOption {
    type = lib.types.submodule {
      options = options;
    };
    default = {};
  };

in
{
  inherit mkIfAnyUser;
  inherit mkOpts;
  inherit perUser;
  inherit perUserHomeManager;
}
