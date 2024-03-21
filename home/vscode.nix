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
    ];
  };
}
