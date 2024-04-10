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
    Service.ExecStart = (libutils.mkNuScript pkgs "clipcatd-start" ''
      mkdir ~/.config/clipcat
      ${pkgs.clipcat}/bin/clipcatd default-config | save -f ~/.config/clipcat/clipcatd.toml
      ${pkgs.clipcat}/bin/clipcatd --no-daemon --replace
    '');
    Install.WantedBy = [ "default.target" ];
  };
}
