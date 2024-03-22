{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      serayuzgur.crates
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers
      nvarner.typst-lsp
      jnoortheen.nix-ide
      mhutchie.git-graph
      thenuprojectcontributors.vscode-nushell-lang
      ms-vscode.hexeditor
      alefragnani.project-manager
      github.copilot
      github.copilot-chat
      streetsidesoftware.code-spell-checker
      vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          name = "code-spell-checker-german";
          publisher = "streetsidesoftware";
          version = "2.3.1";
          sha256 = "sha256-KeYE6/yO2n3RHPjnJOnOyHsz4XW81y9AbkSC/I975kQ=";
        };
      }
    ];
  };

  xdg.configFile."Code/User/settings.json".source = ./settings.json;
  xdg.configFile."Code/User/keybindings.json".source = ./keybindings.json;
}
