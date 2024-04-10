{  pkgs, libutils, ... }:

{
  opts.user.persist.state.files = [
    ".cache/clipcat/clipcatd-history"
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
      mkdir -p ~/.config/clipcat
      ${pkgs.clipcat}/bin/clipcatd default-config | save ~/.config/clipcat/clipcatd.toml
      ${pkgs.clipcat}/bin/clipcatd --no-daemon --replace
    '');
    Install.WantedBy = [ "default.target" ];
  };
}
