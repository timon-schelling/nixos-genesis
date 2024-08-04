{ pkgs, ... }:

{
  platform.user.persist.folders = [
    ".config/chromium"
  ];

  programs.chromium = {
    enable = true;
    package = (pkgs.runCommand "chromium-custom"
      {
        buildInputs = [ pkgs.makeWrapper ];
      }
      ''
        makeWrapper ${pkgs.ungoogled-chromium}/bin/chromium $out/bin/chromium --set NIXOS_OZONE_WL 1
        cp -r "${pkgs.ungoogled-chromium}/share" "$out/"
      ''
    );
  };
}
