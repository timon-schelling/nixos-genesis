{ lib, ... }:

let
  modulesRoot = ../modules;
  dirToModulePath = dir: (lib.strings.removePrefix "./" (lib.path.removePrefix modulesRoot dir));
  modulePathToEnableOptionConfigPath = path: ["modules"] ++ (lib.strings.splitString "/" path);
  dirToModuleConfigPath = dir: modulePathToEnableOptionConfigPath (dirToModulePath dir);
  modulePathToEnableOption = path:
    if path == [] then
      {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          example = true;
          description = "Enables module";
        };
      }
    else
      {
        ${lib.head path} = modulePathToEnableOption (lib.tail path);
      }
  ;

  mkModule = conf: dir: options: config:
    let
      moduleConfigPath = dirToModuleConfigPath dir;
    in
    {
      options = (modulePathToEnableOption moduleConfigPath) // options;
      config = lib.mkIf (lib.attrsets.getAttrFromPath moduleConfigPath conf).enable config;
    }
  ;

  mkUserModule = conf: dir: { user ? { options = {}; config = {}; }, system ? { options = {}; config = {}; }, ... }:
    let
      moduleConfigPath = dirToModuleConfigPath dir;
      anyUserEnabledModule = (lib.attrsets.filterAttrs (name: value: (lib.attrsets.getAttrFromPath moduleConfigPath value).enable) user.config.home-manager.users) != [];
    in
    {
      options = system.options or {};
      config = lib.mkMerge
      (lib.mkIf anyUserEnabledModule (system.config or {}))
      {
        home-manager = {
          users = lib.mapAttrsToList
          (username: _:
            {
              ${username} = {
                imports = [
                  ({ ... }: {
                    options = (modulePathToEnableOption moduleConfigPath) // user.options or {};
                    config = lib.mkIf
                      ((lib.attrsets.getAttrFromPath moduleConfigPath user.config.home-manager.users.${username}).enable)
                      user.config;
                  })
                ];
              };
            }
          )
          conf.home-manager.users;
        };
      };
    }
  ;
in
{
  inherit mkModule;
  inherit mkUserModule;
}
