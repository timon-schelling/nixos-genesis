inputs: self: super:
let
  writeNu = name: script: f: f "${name}" ''
    #!${self.nushell}/bin/nu --stdin

    ${script}
  '';
  nu = {
    writeScript = name: script: writeNu name script self.writeScript;
    writeScriptBin = name: script: writeNu name script self.writeScriptBin;
  };
in
with super;
{
  inherit nu;
  nushell = rustPlatform.buildRustPackage  {
    pname = "nushell";

    version = "0.93.0-unstable-39156930f5241664801828adbb8df20c28ad60f7";
    src = fetchFromGitHub {
      owner = "nushell";
      repo = "nushell";
      rev = "39156930f5241664801828adbb8df20c28ad60f7";
      sha256 = "sha256-PXodkFHFV1IIWy318yJTBqzWSywbddnxpxjRSLfypGY=";
    };

    cargoHash = "sha256-VLdzsn/u0CPsMffbfRQXio/pjllHkAROPcg2oZww4DQ=";

    nativeBuildInputs = [ pkg-config ]
      ++ lib.optionals (stdenv.isLinux) [ python3 ]
      ++ lib.optionals stdenv.isDarwin [ rustPlatform.bindgenHook ];

    buildInputs = [ openssl zstd ]
      ++ lib.optionals stdenv.isDarwin [ zlib Libsystem Security ]
      ++ lib.optionals (stdenv.isLinux) [ xorg.libX11 ]
      ++ lib.optionals (stdenv.isDarwin) [ AppKit nghttp2 libgit2 ];

    doCheck = false;

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
