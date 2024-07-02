{ ... }:

{
  security.sudo.configFile = ''
    root ALL=(ALL:ALL) ALL

    %admin ALL=(ALL:ALL) ALL
  '';

}
