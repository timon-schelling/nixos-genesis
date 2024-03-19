{
  platform = "x86_64-linux";
  host = "timon-pc";
  drive = "/dev/nvme1n1";
  users = {
    timon = {
      name = "Timon Schelling";
      email = "me@timon.zip";
      sudo = true;
    };
  };
}
