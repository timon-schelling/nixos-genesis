{
  system = {
    drive = "/dev/nvme1n1";
    platform = "x86_64-linux";
    login.greeter = "tui";
  };
  users = {
    timon = {
      passwordHash = "***REMOVED***";
      admin = true;
      home = {
        name = "Timon Schelling";
        email = "me@timon.zip";
        persist.data.folders = [
          "dev"
          "data"
          "media"
          "tmp"
        ];
        apps = {
          terminal = {
            rio.enable = true;
            wezterm.enable = true;
          };
          editor = {
            cosmic-edit.enable = true;
            lapce.enable = true;
            vscode.enable = true;
          };
          browser = {
            chromium.enable = true;
            firefox.enable = true;
            tor-browser.enable = true;
          };
          filemanager = {
            gnome.enable = true;
          };
          passwordmanager = {
            enpass.enable = true;
            buttercup.enable = true;
          };
          other = {
            beeper.enable = true;
            discord.enable = true;
            discord-webcord.enable = true;
            spotify.enable = true;
          };
        };
      };
      # desktops.hyprhot.enable = true;
    };
  };
}
