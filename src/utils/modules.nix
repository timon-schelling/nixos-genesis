{ lib, ... }:

let
  modulesRoot = ../modules;
  dirToModulePath = dir: lib.strings.removePrefix "./" (lib.path.removePrefix modulesRoot dir);
  modulePathToEnableOptionConfigPath = path: (["modules"] + (lib.strings.splitString "/" path) + ["enable"]);
  enableOptionConfigPathToEnableOption = path:
    lib.attrsets.setAttrByPath path (lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enables module";
    });

  mkModule = conf: dir: options: config:
    let
      enableOptionConfigPath = modulePathToEnableOptionConfigPath (dirToModulePath dir);
    in
    {
      options = (enableOptionConfigPathToEnableOption enableOptionConfigPath) // options;
      config = lib.mkIf (lib.attrsets.getAttrFromPath enableOptionConfigPath conf) config;
    };
in
{
  inherit mkModule;
}
