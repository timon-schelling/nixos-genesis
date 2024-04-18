{ lib, ... }:

let
  collectModuleFile = { dir, type, opts }:
    let
      path = dir + "/${type}.nix";
    in
    if (builtins.pathExists path) then [ path ] else [];
  collectModulesSubDir = { dir, type, opts }:
    lib.lists.flatten (
      lib.mapAttrsToList
        (file: kind:
          if kind == "directory" then
            collectModule { dir = (dir + "/${file}"); inherit type opts; }
          else []
        )
        (builtins.readDir dir)
    );
  collectModuleDir = { dir, type, opts }:
    collectModuleFile { inherit dir type opts; } ++
    collectModulesSubDir { inherit dir type opts; };
  collectModule = { dir, type, opts }:
    let
      path = dir + "/module.nix";
    in
    if builtins.pathExists path then
      let
        module = import path;
      in
      if (builtins.hasAttr "${type}" module) then
        if (module."${type}" opts) then
          collectModuleDir { inherit dir type opts; }
        else []
      else []
    else collectModuleDir { inherit dir type opts; };

  systemModules = { dir, opts }: collectModule { type = "system"; inherit dir opts; };
  homeModules = { dir, opts }: collectModule { type = "home"; inherit dir opts; };
in
{
  inherit systemModules homeModules;
}
