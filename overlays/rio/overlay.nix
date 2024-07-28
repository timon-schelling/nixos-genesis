inputs: self: super: {
  rio = super.rio.overrideAttrs (drv: rec {
    name = "rio-${version}";
    version = "0.1.0";

    src = super.fetchFromGitHub {
      owner = "raphamorim";
      repo = "rio";
      rev = "v${version}";
      hash = "sha256-Jp8f8u9CkY+pz6QaoWp6P6+OqsIjhzXH0eeoBiSDR0k=";
    };

    cargoDeps = drv.cargoDeps.overrideAttrs (super.lib.const {
      inherit src;
      outputHash = "sha256-3FirYpHxTRvXgRQACVvmwlaCNTyJ8dLbZ258qv5vbsc=";
    });
  });
}
