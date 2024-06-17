{ lib, ... }:

let
  anyMapAttrs = filter: attrs: lib.any (lib.mapAttrsToList (key: value: filter key value) attrs);

  anyUser = config: filter: anyMapAttrs filter config.opts.users;

  mkIfAnyUser = config: filter: content: lib.mkIf (anyUser config filter) (lib.mkMerge [content]);

  perUser = config: function: lib.mkMerge (lib.mapAttrsToList function config.opts.users);

  perUserHomeManager = config: function: perUser config (name: user: {
    home-manager = {
      users = {
        ${name} = function name user;
      };
    };
  });

  mkOpts = { system ? {}, user ? {} }: {
    opts.system = (mkSystemOpts system);
    opts.users = (mkUserOpts user);
  };

  mkUserOpts = options: {
    users = lib.mkOption {
      type = lib.types.attrsetOf (lib.types.submodule {
        options = options;
      });
      default = {};
    };
  };

  mkSystemOpts = options: {
    system = lib.mkOption {
      type = lib.types.submodule {
        options = options;
      };
      default = {};
    };
  };

  # mkUserModule = conf: dir: { user ? { options = {}; config = {}; }, system ? { options = {}; config = {}; }, ... }:
  #   let
  #     moduleConfigPath = dirToModuleConfigPath dir;
  #     anyUserEnabledModule = (lib.attrsets.filterAttrs (name: value: (lib.attrsets.getAttrFromPath moduleConfigPath value).enable) user.config.home-manager.users) != [];
  #   in
  #   {
  #     options = system.options or {};
  #     config = lib.mkMerge
  #       (lib.mkIf anyUserEnabledModule (system.config or {}))
  #       {
  #         home-manager = {
  #           users = lib.mapAttrsToList
  #           (username: user:
  #             {
  #               ${username} = {
  #                 imports = [
  #                   ({ ... }: {
  #                     options = (modulePathToEnableOption moduleConfigPath) // user.options or {};
  #                     config = lib.mkIf
  #                       ((lib.attrsets.getAttrFromPath moduleConfigPath user.config.home-manager.users.${username}).enable)
  #                       user.config;
  #                   })
  #                 ];
  #               };
  #             }
  #           )
  #           conf.home-manager.users;
  #         };
  #       };
  #   }
  # ;
in
{
  inherit mkIfAnyUser;
  inherit mkOpts;
  inherit perUser;
  inherit perUserHomeManager;
}
