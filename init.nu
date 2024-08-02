#!/usr/bin/env nu

mut hostname = ""
mut hostname_selected = false
while (not $hostname_selected) {
    $hostname = (input "What should the hostname be? ")
    if $hostname =~ "^[a-z]([a-z0-9-]*[a-z0-9])?$" {
        $hostname_selected = true
    }
}

let hosts = do { cd hosts; ls | filter { ($in.type == "dir") and ($in.name != "default") } | get name }
let selection = $hosts | prepend ["default" "none"] | input list "What system configuration should be copied? (`none` for empty configuration)"

if $selection == "none" {
    mkdir $"hosts/($hostname)"
    "" | save $"hosts/($hostname)/config.nix"
} else {
    cp -r $"hosts/($selection)" $"hosts/($hostname)"
}

echo $"Created configuration for ($hostname)."
echo "Please verify the configuration before installing."
