{  pkgs, libutils, ... }:

{
  opts.user.persist.state.folders = [
    ".cache/clipcat"
  ];

  home.packages = [
    pkgs.clipcat
  ];

  systemd.user.services.clipcatd = {
    Unit = {
      Description = "Clipboard deamon";
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = (libutils.mkNuScript pkgs "clipcatd-start" ''
        env | save -f ~/tmp/clipcatd.env
        mkdir ~/.config/clipcat
        ${pkgs.clipcat}/bin/clipcatd default-config
          | from toml
          | update max_history 10000
          | update desktop_notification.enable false
          | update metrics.enable false
          | update grpc.enable_http false
          | to toml
          | save -f ~/.config/clipcat/clipcatd.toml
        ${pkgs.clipcat}/bin/clipcatd --no-daemon --replace
      '');
    };
    Install.WantedBy = [ "default.target" ];
  };
}
