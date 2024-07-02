{
  system = {
    drive = "/dev/nvme1n1";
    platform = "x86_64-linux";
  };
  users = {
    timon = {
      passwordHash = "***REMOVED***";
      admin = true;
      home = {
        name = "Timon Schelling";
        email = "me@timon.zip";
        persist.data.folders = [
          "dev"
          "data"
          "media"
          "tmp"
        ];
      };
      # desktops.hyprhot.enable = true;
    };
  };
}
