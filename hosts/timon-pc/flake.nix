(let
  opts = {
    host = "timon-pc";
    drive = "/dev/nvme1n1";
    users = {
      timon = {
        name = "Timon Schelling";
        email = "me@timon.zip";
        sudo = true;
      };
    };
  };
  base = import ../../main.nix;
in base { inherit opts; })
