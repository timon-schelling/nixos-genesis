{ pkgs, ... }:

{
  services = {
    printing.enable = true;
    ipp-usb.enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    disabledDefaultBackends = [ "escl" ];
  };
  programs.system-config-printer.enable = true;
}
