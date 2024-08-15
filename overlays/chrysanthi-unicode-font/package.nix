{ stdenvNoCC, ... }:

stdenvNoCC.mkDerivation rec {
  name = "chrysanthi-unicode-font";

  src = ./font.ttf;

  installPhase = ''
    runHook preInstall

    mv $src ./${name}.ttf
    install -Dm644 -t $out/share/fonts/truetype/ *.ttf

    runHook postInstall
  '';
}