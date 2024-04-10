{  config, pkgs, libutils, ... }:

{
  home.packages = [
    pkgs.clipcat
  ];

  systemd.user.services.clipcatd = {
    Unit = {
      Description = "Clipboard deamon";
      WantedBy = [ "graphical-session.target" ];
    };
    Service.ExecStart = (libutils.mkNuScript pkgs "clipcatd-start" ''
      ${pkgs.clipcat}/bin/clipcatd default-config | save ~/.config/clipcat/clipcatd.toml
      ${pkgs.clipcat}/bin/clipcatd --no-daemon --replace
    '');
    Install.WantedBy = [ "default.target" ];
  };
}
