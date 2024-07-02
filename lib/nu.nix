{ pkgs, ... } :

let
  writeNu = name: script: f: f "${name}" ''
    #!${pkgs.nushell}/bin/nu --stdin

    ${script}
  '';
in
{
  writeNu = name: script: writeNu name script pkgs.writeScript;
  writeNuBin = name: script: writeNu name script pkgs.writeScriptBin;
}
