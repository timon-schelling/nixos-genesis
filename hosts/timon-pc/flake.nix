let
  opts = {
    host = "timon-pc";
    drive = "/dev/nvme1n1";
    users = {
      timon = {

      };
    };
  };
  base = import ../../main.nix { inherit opts; };
in base { inherit opts; }
