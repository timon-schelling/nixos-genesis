{
  inputs = {
    inputs.url = "./../..";
  };
  outputs = i: import ../../outputs.nix (builtins.trace i.inputs.inputs i.inputs.inputs) (builtins.baseNameOf ./.);
}
