Boot the NixOS installation media and run the following commands:

**replace `/dev/nvmeXnX` with your drive**

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disk.nix --arg device '"/dev/nvmeXnX"'
```

run the following command to generate the hardware configuration

```
nixos-generate-config --show-hardware-config > hardware.nix
```

edit `hardware.nix`


replace `hostname` with your hostname

```
nixos-install --root /mnt --flake .#hostname
```
