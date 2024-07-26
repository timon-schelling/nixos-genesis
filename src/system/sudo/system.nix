{ lib, ... }:

{
  security.sudo = {
    extraConfig = ''
      Defaults lecture = never
    '';
    configFile = lib.mkForce ''
      root ALL=(ALL:ALL) SETENV: ALL
      %admin ALL=(ALL:ALL) SETENV: ALL
    '';
  };
}
