# timonos

## laptop install notes

### command

```
sudo nix --extra-experimental-features "nix-command flakes" run --refresh 'github:timon-schelling/nix-disko-install-fix#disko-install' -- --flake .#timon-laptop --disk main /dev/nvme0n1 --debug
```

### problems

- `/etc/machine-id` is not created, leads to failing install or rebuild when using systemd-boot

- `/persist/user/<user>` folder is not created, leads to error in `home-manager-<user>` service
  - needs to be created with `<user>:users` with a service that runs before any user services

- tere asks if shell is configured at first start https://github.com/mgunyho/tere/blob/ef69b8d9da3a97b73896516ee12680d0edae3053/src/main.rs#L13
