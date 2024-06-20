{ pkgs, lib, config, ... }:

{
  options = {
    platform.system.sessions = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.string;
          };
          command = lib.mkOption {
            type = lib.types.string;
          };
        };
      });
      # default = [];
    };
  };

  config = {

    # programs.regreet = {
    #   enable = true;
    #   settings = {
    #     background = {
    #       color = "#161616";
    #     };
    #     GTK = {
    #       theme_name = "adw-gtk3-dark";
    #       application_prefer_dark_theme = true;
    #     };
    #   };
    #   cageArgs = [ "-s" "-m" "last" ];
    # };
    # services.displayManager.sddm = {
    #   enable = true;
    #   wayland.enable = true;
    # };

    platform.system.persist.folders = [
      {
        directory = "/var/cache/tuigreet";
        user = "greeter";
        group = "greeter";
        mode = "0755";
      }
    ];

    environment.systemPackages = builtins.trace config.platform.system.sessions [
      (lib.util.nuscript.mkScript pkgs "select-session" ''
        let sessions = "${builtins.toJSON config.platform.system.sessions}" | from json
        let sessions_number = $sessions | length

        if ($sessions_number == 0) {
          echo "No sessions available"
          exit 1
        }

        let selection = (
          if ($sessions_number == 1) {
            0
          } else {
            $sessions | get name | input list -i -f "Select a session"
          }
        )

        if ($selection == null) {
          echo "No session selected"
          exit 0
        }

        let command = $sessions | get $selection | get command
        ^($command)
      '')
    ];

    services.greetd = {
      enable = true;
      settings = rec {
        tuigreet_session =
          let
            session = "select-session";
            tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
          in
          {
            command = "${tuigreet} --time --remember --cmd ${session}";
            user = "greeter";
          };
        default_session = tuigreet_session;
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
