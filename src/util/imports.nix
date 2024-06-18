{ lib, ... }:

let
  collectModuleFile = type: dir:
    let
      path = dir + "/${type}.nix";
    in
    if (builtins.pathExists path) then [ path ] else [];
  collectModulesSubDir = type: dir:
    lib.lists.flatten (
      lib.mapAttrsToList
        (file: kind:
          if kind == "directory" then
            collectModule { dir = (dir + "/${file}"); inherit type; }
          else []
        )
        (builtins.readDir dir)
    );
  collectModule = type: dir:
    collectModuleFile type dir ++ collectModulesSubDir type dir;

  systemModules = dir: collectModule "system" dir;
  homeModules = dir: collectModule "home" dir;
  overlays = dir: collectModule "overlay" dir;
in
{
  inherit systemModules homeModules overlays;
}
