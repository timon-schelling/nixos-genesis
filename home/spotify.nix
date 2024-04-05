{ pkgs, ... }:

{
  opts.user.state.folders = [
    ".config/spotify"
    ".cache/spotify"
  ];

  home.packages = [
    pkgs.spotify.overrideAttrs (e: rec {
      # Add arguments to the .desktop entry
      desktopItem = e.desktopItem.override (d: {
        exec = "${d.exec} --enable-features=UseOzonePlatform --ozone-platform=wayland";
      });

      # Update the install script to use the new .desktop entry
      installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
    })
  ];
}
