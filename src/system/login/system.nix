{ pkgs, lib, config, ... }:

{
  options = {
    platform.system.sessions = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
          };
          command = lib.mkOption {
            type = lib.types.str;
          };
        };
      });
      default = [];
    };
  };

  config = {

    platform.system.persist.folders = [
      {
        directory = "/var/cache/tuigreet";
        user = "greeter";
        group = "greeter";
        mode = "0755";
      }
    ];

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -g '' --time --remember --remember-user-session --asterisks ";# --sessions ${}";
        user = "greeter";
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
