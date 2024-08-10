#!/usr/bin/env nu

let ddcutil_output = nix run "nixpkgs#ddcutil" "--" detect -t
print $ddcutil_output

let device_names = $ddcutil_output | lines | where { str contains "/dev/" } | parse --regex ".*/dev/(?P<dev>i2c-.*)" | get dev
print $device_names

let target_files = $device_names | each { $"/sys/bus/i2c/devices/($in)/new_device" }
$target_files | each { |it| try { "ddcci 0x37" | save -f $it } }
print $target_files
