{ ... }:

let
  mkScript = pkgs: name: script: pkgs.writeScriptBin "${name}" ''
    #!${pkgs.nushell}/bin/nu --stdin

    ${script}
  '';
in
{
  inherit mkScript;
}
