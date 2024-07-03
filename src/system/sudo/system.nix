{ lib, ... }:

{
  security.sudo = {
    configFile = ''
      root ALL=(ALL:ALL) ALL

      %admin ALL=(ALL:ALL) SETENV: ALL
    '';
    extraRules = lib.mkForce [];
  };
}
