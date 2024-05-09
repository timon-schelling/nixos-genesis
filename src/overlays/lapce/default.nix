{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, libgit2
, libxkbcommon
, openssl
, vulkan-loader
, zlib
, stdenv
, darwin
, wayland
}:

rustPlatform.buildRustPackage rec {
  pname = "lapce";
  version = "unstable-2024-05-09";

  src = fetchFromGitHub {
    owner = "timon-schelling";
    repo = "lapce";
    rev = "611196c54c68bdfa974154e6544d0f4b6cfa6bc7";
    hash = "sha256-JjR+/QMZlR2eCkpwWOozijs3PiMNveGCTme7646W0Lg=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "floem-0.1.1" = "sha256-AH2HtfK2qKLlTNu6oMTSLd21yqeJGW3I82q/lbbJZfg=";
      "human-sort-0.2.2" = "sha256-tebgIJGXOY7pwWRukboKAzXY47l4Cn//0xMKQTaGu8w=";
      "lsp-types-0.95.1" = "sha256-+tWqDBM5x/gvQOG7V3m2tFBZB7smgnnZHikf9ja2FfE=";
      "psp-types-0.1.0" = "sha256-/oFt/AXxCqBp21hTSYrokWsbFYTIDCrHMUBuA2Nj5UU=";
      "regalloc2-0.9.3" = "sha256-tzXFXs47LDoNBL1tSkLCqaiHDP5vZjvh250hz0pbEJs=";
      "structdesc-0.1.0" = "sha256-gMTnRudc3Tp9JRa+Cob5Ke23aqajP8lSun5CnT13+eQ=";
      "tracing-0.2.0" = "sha256-31jmSvspNstOAh6VaWie+aozmGu4RpY9Gx2kbBVD+CI=";
      "tree-sitter-bash-0.19.0" = "sha256-gTsA874qpCI/N5tmBI5eT8KDaM25gXM4VbcCbUU2EeI=";
      "tree-sitter-md-0.1.2" = "sha256-gKbjAcY/x9sIxiG7edolAQp2JWrx78mEGeCpayxFOuE=";
      "wasi-experimental-http-wasmtime-0.10.0" = "sha256-FuF3Ms1bT9bBasbLK+yQ2xggObm/lFDRyOvH21AZnQI=";
    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libgit2
    libxkbcommon
    openssl
    vulkan-loader
    zlib
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.CoreGraphics
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.Foundation
    darwin.apple_sdk.frameworks.Metal
    darwin.apple_sdk.frameworks.QuartzCore
    darwin.apple_sdk.frameworks.Security
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = with lib; {
    description = "Lightning-fast and Powerful Code Editor written in Rust";
    homepage = "https://github.com/timon-schelling/lapce";
    changelog = "https://github.com/timon-schelling/lapce/blob/${src.rev}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
    mainProgram = "lapce";
  };
}
