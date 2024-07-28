inputs: self: super: {
  # rio = super.rio.overrideAttrs (drv:
  #   let
  #     version = "0.1.0";
  #     name = "rio-${version}";
  #     src = super.fetchFromGitHub {
  #       owner = "raphamorim";
  #       repo = "rio";
  #       rev = "refs/tags/v${version}";
  #       hash = "sha256-Jp8f8u9CkY+pz6QaoWp6P6+OqsIjhzXH0eeoBiSDR0k=";
  #     };
  #   in
  #   {
  #     inherit name version src;
  #     cargoDeps = drv.cargoDeps.overrideAttrs (super.lib.const {
  #       inherit src version;
  #       outputHash = "sha256-7xYZAKdn0v/dsPvdfs7Ijrz7z3eXepf2I/ogvMG79yI=";
  #     });
  #   }
  # );
}
