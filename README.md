# timonos

## laptop install notes

### command

installer iso:
https://releases.nixos.org/nixos/22.05/nixos-22.05.4694.380be19fbd2/nixos-gnome-22.05.4694.380be19fbd2-x86_64-linux.iso

boot it via ventoy in nomodset mode

mount ventoy stick with this repo on it (gnome file explorer)

connect wifi

`passwd nixos` to set password for ssh

`ifconfig -a` to get ip

`ssh nixos@<ip>`

`sudo dd if=/dev/zero of=/run/media/nixos/utils/.data/.nixos-install-tmp-swapfile bs=1024 count=41940000`

`sudo chmod 600 /run/media/nixos/utils/.data/.nixos-install-tmp-swapfile`

`sudo mkswap /run/media/nixos/utils/.data/.nixos-install-tmp-swapfile`

`sudo swapon /run/media/nixos/utils/.data/.nixos-install-tmp-swapfile`

`sudo mount -o remount,size=40G,noatime /nix/.rw-store`

`cd <repo dir>`

`git pull`

```
sudo nix --extra-experimental-features "nix-command flakes" run --refresh 'github:timon-schelling/nix-disko-install-fix#disko-install' -- --flake .#timon-laptop --disk main /dev/nvme0n1 --debug
```

### problems

- `/etc/machine-id` is not created, leads to failing install or rebuild when using systemd-boot

- `/persist/user/<user>` folder is not created, leads to error in `home-manager-<user>` service
  - needs to be created with `<user>:users` with a service that runs before any user services

- tere asks if shell is configured at first start https://github.com/mgunyho/tere/blob/ef69b8d9da3a97b73896516ee12680d0edae3053/src/main.rs#L13
