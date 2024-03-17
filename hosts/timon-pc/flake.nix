let
  opts = {
    host = "timon-pc";
    drive = "/dev/nvme1n1";
    users = {
      timon = {

      };
    };
  };
in import ../../main.nix { inherit opts; }
