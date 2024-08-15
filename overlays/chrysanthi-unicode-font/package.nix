{ stdenvNoCC, ... }:

stdenvNoCC.mkDerivation rec {
  name = "chrysanthi-unicode-font";
  unpackPhase = "true";
  installPhase = ''
    runHook preInstall

    cp ${./font.ttf} ./${name}.ttf
    install -Dm644 -t $out/share/fonts/truetype/ *.ttf

    runHook postInstall
  '';
}