{
  opts = {
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
        desktops.hyprhot.enable = false;
      };
      simon = {
        name = "Simon Schelling";
        email = "me@simon.zip";
        passwordHash = "***REMOVED***";
        sudo = true;
        desktops.hyprhot.enable = true;
      };
    };
  };
}
