{ pkgs, ... } :

builtins.trace pkgs {
  writeNuBin = name: script: pkgs.writeScript "${name}" ''
    #!${pkgs.nushell}/bin/nu --stdin

    ${script}
  '';
}
