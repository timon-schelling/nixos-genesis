{
  system = {
    host = "builtins.baseNameOf ./.";
    drive = "/dev/nvme1n1";
    platform = "x86_64-linux";
  };
  users = {
    timon = {
      name = "Timon Schelling";
      email = "me@timon.zip";
      passwordHash = "***REMOVED***";
      sudo = true;
      persist.data.folders = [
        "dev"
        "data"
        "media"
        "tmp"
      ];
      desktops.hyprhot.enable = true;
    };
  };
}
