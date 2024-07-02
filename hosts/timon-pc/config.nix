{
  system = {
    drive = "/dev/nvme1n1";
    platform = "x86_64-linux";
  };
  users = {
    timon = {
      passwordHash = "***REMOVED***";
      admin = true;
      persist.data.folders = [
        "dev"
        "data"
        "media"
        "tmp"
      ];
      home = {
        name = "Timon Schelling";
        email = "me@timon.zip";
      };
      # desktops.hyprhot.enable = true;
    };
  };
}
