{ lib, ... }:

let
  modulesRoot = ../modules;
  dirToModulePath = dir: lib.strings.removePrefix "./" (lib.path.removePrefix modulesRoot dir);
  modulePathToEnableOptionConfigPath = path: (["modules"] + (lib.strings.splitString "/" path) + ["enable"]);
  enableOptionConfigPathToEnableOption = path:
    if lib.length == 0 then
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
        ${lib.head path} = lib.mkOption {
          type = lib.types.submodule (enableOptionConfigPathToEnableOption (lib.tail path));
        };
      }
  ;

  mkModule = conf: dir: options: config:
    let
      enableOptionConfigPath = modulePathToEnableOptionConfigPath (dirToModulePath dir);
    in
    {
      options = (enableOptionConfigPathToEnableOption enableOptionConfigPath) // options;
      config = lib.mkIf (lib.attrsets.getAttrFromPath enableOptionConfigPath conf) config;
    }
  ;
in
{
  inherit mkModule;
}
