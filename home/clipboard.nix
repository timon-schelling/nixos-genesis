{ pkgs, ... }:

{
  home.packages = [
    pkgs.clipcat
  ];

  systemd.user.services.clipcatd = {
    Unit = {
      Description = "Clipboard deamon";
      WantedBy = [ "graphical-session.target" ];
    };
    Service.ExecStart = "${pkgs.clipcat}/bin/clipcatd --no-daemon --replace";
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
