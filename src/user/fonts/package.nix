{ stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  name = "chrysanthi-unicode-font";
  unpackPhase = "true";
  installPhase = ''
    runHook preInstall

    cp -r ${./ttfs}/* $out/share/fonts/truetype/
    chmod -R 644 $out/share/fonts/truetype/

    runHook postInstall
  '';
}