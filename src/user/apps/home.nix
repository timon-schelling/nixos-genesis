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
    lib.lists.init (lib.strings.splitString "/" (lib.strings.removePrefix "./" (lib.path.removePrefix appsFolder path)))
  ) appFiles;
  buildAppTreeFromList = list: builtins.foldl (a: e:
    let
      head = lib.lists.last (lib.lists.take 1 e);
      tail = lib.lists.drop 1 e;
    in
    a // ({
      "${head}" = if tail != [] then buildAppTreeFromList tail else {};
    })
  )
  list;
  appTree = buildAppTreeFromList apps;
in
{
  options.apps = builtins.trace (builtins.toJSON ({a = apps; b = appTree;})) {

  };
}
