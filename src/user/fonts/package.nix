{ stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  name = "fonts";
  unpackPhase = "true";
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype/
    cp -r ${./ttfs}/* $out/share/fonts/truetype/

    runHook postInstall
  '';
}