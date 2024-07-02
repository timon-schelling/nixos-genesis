{ lib, pkgs, ... } @ args :

{
  writeNuBin = name: script: pkgs.writeScriptBin "${name}" ''
    #!${pkgs.nushell}/bin/nu --stdin

    ${script}
  '';
}
