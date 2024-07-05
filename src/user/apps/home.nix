{ config, lib, ... }:

let
  # collectAppFile = dir:
  #   let
  #     path = (dir + "/app.nix");
  #   in
  #   if (builtins.pathExists path) then [ path ] else [];
  # collectModulesSubDir = type: dir:
  #   lib.lists.flatten (
  #     lib.mapAttrsToList
  #       (file: kind:
  #         if kind == "directory" then
  #           collectModule type (dir + "/${file}")
  #         else []
  #       )
  #       (builtins.readDir dir)
  #   );
  # collectModule = type: dir:
  #   (collectModuleFile type dir) ++ (collectModulesSubDir type dir);
  appsFolder = ./.;
  appFiles = lib.imports.type "app" appsFolder;
  apps = lib.map (path:
    lib.list.init (lib.strings.splitString "/" (lib.strings.removePrefix "./" (lib.path.removePrefix appsFolder path)))
  ) appFiles;
in
{
  options.apps = builtins.trace (builtins.toJSON apps) {

  };
}
