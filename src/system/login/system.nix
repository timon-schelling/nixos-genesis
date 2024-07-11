{ pkgs, lib, config, ... }:

{

  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  services.displayManager.enable = true;

  # greetd config
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "cosmic-greeter";
        command = ''${pkgs.coreutils}/bin/env XCURSOR_THEME="''${XCURSOR_THEME:-Pop}" systemd-cat -t cosmic-greeter ${pkgs.cosmic-comp}/bin/cosmic-comp ${pkgs.cosmic-greeter}/bin/cosmic-greeter'';
      };
    };
  };

  # daemon for querying background state and such
  systemd.services.cosmic-greeter-daemon = {
    wantedBy = [ "multi-user.target" ];
    before = [ "greetd.service" ];
    serviceConfig = {
      Type = "dbus";
      BusName = "com.system76.CosmicGreeter";
      ExecStart = "${pkgs.cosmic-greeter}/bin/cosmic-greeter-daemon";
      Restart = "on-failure";
    };
  };

  # greeter user (hardcoded in cosmic-greeter)
  systemd.tmpfiles.rules = [
    "d '/var/lib/cosmic-greeter' - cosmic-greeter cosmic-greeter - -"
  ];

  users.users.cosmic-greeter = {
    isSystemUser = true;
    home = "/var/lib/cosmic-greeter";
    group = "cosmic-greeter";
  };

  users.groups.cosmic-greeter = { };

  # required features
  hardware.graphics.enable = true;
  services.libinput.enable = true;

  # required dbus services
  services.accounts-daemon.enable = true;

  # required for authentication
  security.pam.services.cosmic-greeter = {};

  # dbus definitions
  services.dbus.packages = [ pkgs.cosmic-greeter ];

  # platform.system.persist.folders = [
  #   {
  #     directory = "/var/cache/tuigreet";
  #     user = "greeter";
  #     group = "greeter";
  #     mode = "0755";
  #   }
  # ];

  # services.greetd = {
  #   enable = true;
  #   vt = 2;
  #   settings.default_session = {
  #     command = "${pkgs.greetd.tuigreet}/bin/tuigreet -g '' --time --remember --remember-user-session --asterisks";
  #     user = "greeter";
  #   };
  # };

  # boot.kernelParams = [ "console=tty1" ];

  # systemd.services.greetd = {
  #   serviceConfig = {
  #     Type = "idle";
  #   };
  # };
}
