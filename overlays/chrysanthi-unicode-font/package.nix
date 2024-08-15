{ stdenvNoCC, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "chrysanthi-unicode-font";

  src = ./font.ttf;

  installPhase = ''
    runHook preInstall

    mv ./font.ttf ./${pname}.ttf
    install -Dm644 -t $out/share/fonts/truetype/ *.ttf

    runHook postInstall
  '';
}