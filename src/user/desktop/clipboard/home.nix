{  pkgs, lib, ... }:

{
  platform.user.persist.folders = [
    ".cache/clipcat"
  ];

  home.packages = [
    pkgs.clipcat
    pkgs.wl-clipboard-rs
    (lib.writeNuBin "clipboard-history" ''
      let clipboard = (clipcatctl list | split list "\n" | each { |x| $x | parse --regex '(?P<id>\w*)\: (?P<text>.*)' }).0
      let selection = ($clipboard | get text | str join "\n" | select-ui)
      let selection_id = ($clipboard | where { |x| $x.text == $selection }).0.id
      clipcatctl get $selection_id | wl-copy
    '')
  ];

  systemd.user.services.clipcatd = {
    Unit = {
      Description = "Clipboard deamon";
      PartOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${(lib.writeNuBin "clipcatd-start" ''
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
      '')}/bin/clipcatd-start";
      Restart = "on-failure";
      Type = "simple";
    };
  };
}
