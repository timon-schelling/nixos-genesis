self: super: with super; {
  lapce =
    let
      rpathLibs = lib.optionals stdenv.isLinux [
        libGL
        libxkbcommon
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXrandr
        xorg.libXxf86vm
        xorg.libxcb
        wayland
      ];
    in
    rustPlatform.buildRustPackage rec {
      pname = "lapce";
      version = "main-611196c54c68bdfa974154e6544d0f4b6cfa6bc7";

      src = fetchFromGitHub {
        owner = "timon-schelling";
        repo = "lapce";
        rev = "611196c54c68bdfa974154e6544d0f4b6cfa6bc7";
        sha256 = "sha256-x/EObvrMZ3bkdHk5SbfQEarXA7jcQ9rEFZINQrHjcl4=";
      };

      cargoHash = "";

      env = {
        # Get openssl-sys to use pkg-config
        OPENSSL_NO_VENDOR = 1;

        # This variable is read by build script, so that Lapce editor knows its version
        RELEASE_TAG_NAME = "${version}";
      };

      postPatch = ''
        substituteInPlace lapce-app/Cargo.toml --replace ", \"updater\"" ""
      '';

      nativeBuildInputs = [
        cmake
        pkg-config
        perl
        python3
        wrapGAppsHook3 # FIX: No GSettings schemas are installed on the system
        gobject-introspection
      ];

      buildInputs = rpathLibs ++ [
        glib
        gtk3
        openssl
      ] ++ lib.optionals stdenv.isLinux [
        fontconfig
      ] ++ lib.optionals stdenv.isDarwin [
        libobjc
        Security
        CoreServices
        ApplicationServices
        Carbon
        AppKit
      ];

      postInstall = if stdenv.isLinux then ''
        install -Dm0644 $src/extra/images/logo.svg $out/share/icons/hicolor/scalable/apps/dev.lapce.lapce.svg
        install -Dm0644 $src/extra/linux/dev.lapce.lapce.desktop $out/share/applications/lapce.desktop

        $STRIP -S $out/bin/lapce

        patchelf --add-rpath "${lib.makeLibraryPath rpathLibs}" $out/bin/lapce
      '' else ''
        mkdir $out/Applications
        cp -r extra/macos/Lapce.app $out/Applications
        ln -s $out/bin $out/Applications/Lapce.app/Contents/MacOS
      '';

      dontPatchELF = true;

      passthru.updateScript = nix-update-script { };

      meta = with lib; {
        description = "Lightning-fast and Powerful Code Editor written in Rust";
        homepage = "https://github.com/lapce/lapce";
        changelog = "https://github.com/lapce/lapce/releases/tag/v${version}";
        license = with licenses; [ asl20 ];
        maintainers = with maintainers; [ elliot ];
        mainProgram = "lapce";
        # Undefined symbols for architecture x86_64: "_NSPasteboardTypeFileURL"
        broken = stdenv.isDarwin && stdenv.isx86_64;
      };
    };
}
