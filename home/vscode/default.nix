{ pkgs, ... }:

{
  opts.user.persist.state.folders = [
    ".config/Code"
    ".vscode"
  ];

  programs.vscode = {
    enable = true;
    package = (pkgs.runCommand "vscode-wayland"
      {
        buildInputs = [ pkgs.makeWrapper ];
        version = pkgs.vscode.version;
        pname = pkgs.vscode.pname;
      }
      ''
        makeWrapper ${pkgs.vscode}/bin/code $out/bin/code --set NIXOS_OZONE_WL 1
        mkdir -p "$out/share/applications/"
        cp "${pkgs.vscode}/share/applications/code.desktop" "$out/share/applications/"
      ''
    );
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
      github.copilot
      github.copilot-chat
      streetsidesoftware.code-spell-checker
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "code-spell-checker-german";
        publisher = "streetsidesoftware";
        version = "2.3.1";
        sha256 = "sha256-LxgftSpGk7+SIUdZcNpL7UZoAx8IMIcwPYIGqSfVuDc=";
      }
    ];
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;
    userSettings = (builtins.fromJSON (builtins.readFile ./settings.json));
    keybindings = (builtins.fromJSON (builtins.readFile ./keybindings.json));
  };

  home.packages = [
    pkgs.nil
  ];
}
