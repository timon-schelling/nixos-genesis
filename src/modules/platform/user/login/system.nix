{ pkgs, ... }:

{
  # programs.regreet = {
  #   enable = true;
  #   settings = {
  #     background = {
  #       color = "#161616";
  #     };
  #     GTK = {
  #       theme_name = "adw-gtk3-dark";
  #       application_prefer_dark_theme = true;
  #     };
  #   };
  #   cageArgs = [ "-s" "-m" "last" ];
  # };
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };

  platform.system.persist.folders = [
    {
      directory = "/var/cache/tuigreet";
      user = "greeter";
      group = "greeter";
      mode = "0755";
    }
  ];

  services.greetd = {
    enable = true;
    settings = rec {
      tuigreet_session =
        let
          session = "${pkgs.hyprland}/bin/Hyprland";
          tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
        in
        {
          command = "${tuigreet} --time --remember --remember-user-session --cmd ${session}";
          user = "greeter";
        };
      default_session = tuigreet_session;
    };
  };
}
