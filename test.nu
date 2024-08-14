#!/usr/bin/env nu

if ('/tmp/ddcci-load-i2c-devices.lock' | path exists) {
    print "Already running"
    exit 0
}

$nu.pid | save /tmp/ddcci-load-i2c-devices.lock

if ((open /tmp/ddcci-load-i2c-devices.lock | into int) == $nu.pid) {
     print "Lock acquired"
} else {
    print $"Failed to acquire lock ($nu.pid)"
    exit 1
}

def get_device_names [] {
    let ddcutil_output = nix run "nixpkgs#ddcutil" "--" detect -t
    print $ddcutil_output

    $ddcutil_output | lines | where { str contains "/dev/" } | parse --regex ".*/dev/(?P<dev>i2c-.*)" | get dev
}

mut device_names = get_device_names

while (($device_names | length) != 3) {
    sleep 1sec
    $device_names = get_device_names
}
print $device_names

let target_files = get_device_names | each { $"/sys/bus/i2c/devices/($in)/new_device" }
$target_files | each { |it| try { "ddcci 0x37" | save -f $it } }
print $target_files
