#!/usr/bin/env nu

def main [hostname: string] {
    sudo nix run 'github:nix-community/disko#disko-install' -- --flake $".#($hostname)"
}
