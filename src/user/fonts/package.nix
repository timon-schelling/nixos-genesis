{ stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  name = "chrysanthi-unicode-font";
  unpackPhase = "true";
  installPhase = ''
    runHook preInstall

    cp -r ${./ttfs} ./
    install -Dm644 -t $out/share/fonts/truetype/ ttfs/*.ttf

    runHook postInstall
  '';
}