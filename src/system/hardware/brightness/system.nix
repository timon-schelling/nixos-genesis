{ pkgs, ... }:

{
  systemd.services."ddcci-load-i2c-devices" = {
    enable = false;
    description = "Load ddcci devices on i2c bus via sysfs";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${(pkgs.nu.writeScriptBin "ddcci-load-i2c-devices" ''
        let ddcutil_output = ${pkgs.ddcutil}/bin/ddcutil detect -t
        print $ddcutil_output

        let device_names = $ddcutil_output | lines | where { str contains "/dev/" } | parse --regex ".*/dev/(?P<dev>i2c-.*)" | get dev
        print $device_names

        let target_files = $device_names | each { $"/sys/bus/i2c/devices/($in)/new_device" }
        $target_files | par-each { |it| try { "ddcci 0x37" | save -f $it } }
        print $target_files
      '')}/bin/ddcci-load-i2c-devices";
      RemainAfterExit = true;
      Restart = "on-failure";
    };
  };
}
