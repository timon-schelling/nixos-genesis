{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  security.lockKernelModules = true;
}
