{ lib, ... }:

let
  collectDirRecursive = dir: lib.mapAttrs
    (file: type:
      if type == "directory" then collectDirRecursive "${dir}/${file}" else type
    )
    (builtins.readDir dir);
  listDirRecursive = dir: lib.collect lib.isString (lib.mapAttrsRecursive (path: type: lib.concatStringsSep "/" path) (collectDirRecursive dir));
  searchDirForModules = dir: map
    (file: dir + "/${file}")
    (lib.filter
      (file: lib.hasSuffix ".nix" file)
      (listDirRecursive dir));
  searchModules = dirs: lib.lists.flatten (map
    (dir: searchDirForModules dir)
    dirs);

  mkNuScript = nupkg: name: script: lib.mk.writeTextFile {
      inherit name;
      destination = "/bin/${name}";
      text = ''
        #!${nupkg}/bin/nu

        ${script}
      '';
      executable = true;
    };
in
{
  inherit searchModules;
  inherit mkNuScript;
}
