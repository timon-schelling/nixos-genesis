{
  system = {
    host = "timon-pc";
    drive = "/dev/nvme1n1";
  };
  users = {
    timon = {
      name = "Timon Schelling";
      email = "me@timon.zip";
      passwordHash = "***REMOVED***";
      sudo = true;
      desktops.hyprhot.enable = true;
    };
  };
}
