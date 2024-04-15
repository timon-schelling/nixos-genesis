# timonos

## develop with repl

`:r` reload, clears variables and releoads files (needed for imports)

### 1 import

```
> utils = import ./utils.nix { lib = (import <nixpkgs> {}).pkgs.lib; }
> utils.searchHomeModules [ ./. ]
[
  /workspaces/timonos/home.nix
  /workspaces/timonos/options/home.nix
]
```
