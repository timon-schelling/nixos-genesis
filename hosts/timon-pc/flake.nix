{
  inputs = import ../../inputs.nix;

  outputs = inputs:
    import ../../main.nix {
      inherit inputs;
      host = builtins.baseNameOf ./.;
    };
}
