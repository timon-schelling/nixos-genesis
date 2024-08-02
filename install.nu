#!/usr/bin/env nu

def main [hostname: string] {
    sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake $".#($hostname)"
}
