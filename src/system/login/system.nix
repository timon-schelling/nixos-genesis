{ pkgs, lib, config, ... }:

{
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
    vt = 2;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet -g '' --time --remember --remember-user-session --asterisks";
      user = "greeter";
    };
  };

  boot.kernelParams = [ "console=tty1" ];

  systemd.services.greetd = {
    unitConfig = {
         After = lib.mkOverride 0 [ "multi-user.target" ];
    };
    serviceConfig = {
      Type = "idle";
    };
  };
}
