# timonos

sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake .#timon-laptop --disk main /dev/nvme0p1

