{ inputs, opts, ... }:

let
  lib = inputs.nixpkgs.lib;
  utils = import ./utils.nix { inherit lib; };
  imports = utils.searchModules [
    ./system
    # ./user
  ];
in
{
  nixosConfigurations = {
    ${opts.host} = lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit utils;
      };
      modules = [
        inputs.home-manager.nixosModules.default
        inputs.disko.nixosModules.default
        inputs.impermanence.nixosModules.impermanence

        # ./options.nix
        {
          inherit imports;

          options = {
            opts = lib.mkOption {
              type = lib.types.submodule {
                options = lib.mkMerge [
                  {
                    platform = lib.mkOption {
                      type = lib.types.str;
                      default = "x86_64-linux";
                    };
                    drive = lib.mkOption {
                      type = lib.types.path;
                    };
                    host = lib.mkOption {
                      type = lib.types.str;
                    };
                    swap = lib.types.submodule {
                      options = {
                        enable = lib.mkOption {
                          type = lib.types.bool;
                          default = true;
                        };
                        size = lib.mkOption {
                          type = lib.types.str;
                          default = "32G";
                        };
                      };
                    };
                    monitors = lib.mkOption {
                      type = lib.types.listOf (lib.types.submodule {
                        options = {
                          enabled = lib.mkOption {
                            type = lib.types.bool;
                            default = true;
                          };
                          name = lib.mkOption {
                            type = lib.types.str;
                            example = "DP-1";
                          };
                          primary = lib.mkOption {
                            type = lib.types.bool;
                            default = false;
                          };
                          width = lib.mkOption {
                            type = lib.types.int;
                            example = 1920;
                          };
                          height = lib.mkOption {
                            type = lib.types.int;
                            example = 1080;
                          };
                          x = lib.mkOption {
                            type = lib.types.int;
                            default = 0;
                          };
                          y = lib.mkOption {
                            type = lib.types.int;
                            default = 0;
                          };
                        };
                      });
                    };
                  }
                  {
                    users = lib.types.attrsOf (lib.types.submodule {
                      options = {
                        name = lib.mkOption {
                          type = lib.types.str;
                          default = "User";
                        };
                        email = lib.mkOption {
                          type = lib.types.str;
                          default = "";
                        };
                        sudo = lib.mkOption {
                          type = lib.types.bool;
                          default = false;
                        };
                        groups = lib.mkOption {
                          type = lib.types.listOf lib.types.str;
                          default = [ ];
                        };
                      };
                    });
                  }
                ];
              };
            };
          };
          config = {
            inherit opts;
          };
        }
      ];
    };
  };
}
