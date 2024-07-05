{ config, lib, ... }:

let
  appsFolder = ./.;
  appFiles = lib.imports.type "app" appsFolder;
  apps = lib.map (path: lib.strings.splitString "/" (lib.strings.removePrefix "./" (lib.path.removePrefix appsFolder path))) appFiles;
in
{
  options.apps = builtins.trace apps {

  };
}
