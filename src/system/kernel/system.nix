{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_6_7;
  security.lockKernelModules = true;
}
