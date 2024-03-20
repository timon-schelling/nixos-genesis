{
  opts = {
    system = {
      host = "timon-pc";
      drive = "/dev/nvmeXnX";
    };
    users = {
      timon = {
        name = "Timon Schelling";
        email = "me@timon.zip";
        passwordHash = "***REMOVED***";
        sudo = true;
      };
    };
  };
}
