self: super: with super; {
  nushell = rustPlatform.buildRustPackage  {
    pname = "nushell";

    version = "0.93.0-unstable-7a86b98f61e16ac4b1264e86d992aed7d83ca897";
    src = fetchFromGitHub {
      owner = "nushell";
      repo = "nushell";
      rev = "7a86b98f61e16ac4b1264e86d992aed7d83ca897";
      sha256 = "sha256-b7rKUnnKmZAaoxQOa4aCpIU3/LUPgt8bVj00WuCSYA4=";
    };

    cargoHash = "";

    nativeBuildInputs = [ pkg-config ]
      ++ lib.optionals (withDefaultFeatures && stdenv.isLinux) [ python3 ]
      ++ lib.optionals stdenv.isDarwin [ rustPlatform.bindgenHook ];

    buildInputs = [ openssl zstd ]
      ++ lib.optionals stdenv.isDarwin [ zlib Libsystem Security ]
      ++ lib.optionals (withDefaultFeatures && stdenv.isLinux) [ xorg.libX11 ]
      ++ lib.optionals (withDefaultFeatures && stdenv.isDarwin) [ AppKit nghttp2 libgit2 ];

    buildNoDefaultFeatures = !withDefaultFeatures;
    buildFeatures = additionalFeatures [ ];

    inherit doCheck;

    checkPhase = ''
      runHook preCheck
      echo "Running cargo test"
      HOME=$(mktemp -d) cargo test
      runHook postCheck
    '';

    passthru = {
      shellPath = "/bin/nu";
      tests.version = testers.testVersion {
        package = nushell;
      };
      updateScript = nix-update-script { };
    };

    meta = with lib; {
      description = "A modern shell written in Rust";
      homepage = "https://www.nushell.sh/";
      license = licenses.mit;
      maintainers = with maintainers; [ Br1ght0ne johntitor joaquintrinanes ];
      mainProgram = "nu";
    };
  };
}
