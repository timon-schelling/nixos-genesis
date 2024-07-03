{ lib, ... }:

{
  security.sudo = {
    configFile = lib.mkForce ''
      root ALL=(ALL:ALL) ALL

      %admin ALL=(ALL:ALL) SETENV: ALL
    '';
    extraRules = lib.mkForce [];
  };
}
