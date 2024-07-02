{ pkgs, ... } :

builtins.trace pkgs {
  writeNuBin = name: script: pkgs.writeScriptBin "${name}" ''
    #!${pkgs.nushell}/bin/nu --stdin

    ${script}
  '';
}
