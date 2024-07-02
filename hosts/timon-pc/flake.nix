{
  inputs = import ../../inputs.nix;
  outputs = i: import ../../outputs.nix i (builtins.baseNameOf ./.);
}
