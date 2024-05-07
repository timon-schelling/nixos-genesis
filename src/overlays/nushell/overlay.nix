self: super: {
  nushell = super.nushell.overrideAttrs (_: {
    version = "0.93.0-unstable-7a86b98f61e16ac4b1264e86d992aed7d83ca897";
    src = self.fetchFromGitHub {
      owner = "nushell";
      repo = "nushell";
      rev = "7a86b98f61e16ac4b1264e86d992aed7d83ca897";
      sha = "";
    };
  });
}
