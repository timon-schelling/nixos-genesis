{ pkgs, ... } :

builtins.trace pkgs.writeScript {
  writeNuBin = name: script: pkgs.writeScript "${name}" ''
    #!${pkgs.nushell}/bin/nu --stdin

    ${script}
  '';
}
