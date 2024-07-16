{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_6_6;
  security.lockKernelModules = true;
}
