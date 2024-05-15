{ config, lib, ... }:

# let
#   appsFolder = ../../../apps;
#   appTypes = [
#     "terminal"
#     "browser"
#     "editor"
#     "filemanager"
#   ];
#   mkDefaultAppOption = type: lib.mkOption {
#     type = lib.types.enum (lib.mapAttrsToList (file: kind: file) (builtins.readDir (appsFolder + "/" + type)));
#   };
#   mkDefaultAppsOption = lib.mkOption {
#     type = lib.types.submodule {
#       options = ()
#     };
#   };
# in
# {
#   options.platform.user.defaultApps = lib.mkOption {
#     type = lib.types.submodule {
#       options = {
#         terminal = defaultAppOptionFromDir ../../../apps/terminal;
#         browser = defaultAppOptionFromDir ../../../apps/browser;

#       };
#     };
#   };
#   config = {

#   };
# }

{}
