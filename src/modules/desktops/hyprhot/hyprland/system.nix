{ opts, inputs, config, lib, ... }:

{
  options = lib.util.modules.mkOpts {
    user.desktops.hyprhot.enable = lib.mkEnableOption "hyprhot";
  };
  config = lib.util.modules.mkIfAnyUser opts (_: user: user.desktops.hyprhot.enable) (
    {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${opts.system.platform}.hyprland;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = true;
      };

      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };
    } // builtins.trace( builtins.head (lib.util.modules.perUserHomeManager opts (_: user: {
      wayland.windowManager.hyprland = builtins.trace user.desktops.hyprhot.enable {
        enable = true;
        package = inputs.hyprland.packages.${opts.system.platform}.hyprland;
        xwayland.enable = true;
        systemd.enable = true;
        plugins = [
        #    inputs.split-monitor-workspaces.packages.${opts.system.platform}.split-monitor-workspaces
        ];
        extraConfig = ''
          monitor = DP-3, 2560x1440, 1200x250, 1
          monitor = DP-2, 1920x1200, 0x0, 1, transform, 1
          monitor = DP-1, 1920x1200, 3760x0, 1, transform, 1
          monitor = ,preferred, auto, auto

          # cursor settings
          # env = XCURSOR_SIZE, 24
          env = WLR_NO_HARDWARE_CURSORS, 1

          # fix GTK Theme
          env = GTK_THEME, WhiteSur-Dark-solid

          input {
              # `compose:sclk` sets scrolllock as the compose key, needed by keyd
              kb_options = compose:sclk

              follow_mouse = 1
              touchpad {
                  natural_scroll = no
              }
              sensitivity = 0 # -1.0 - 1.0, 0 means no modification
          }

          general {
              gaps_in = 5
              gaps_out = 7
              border_size = 4

              # col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
              # col.active_border = rgba(0052a5ee) rgba(760060ee) 30deg
              # col.active_border = rgba(ffb500ee) rgba(760060ee) rgba(0052a5ee) 30deg
              # col.active_border = rgba(ee00acee) rgba(ffb500ee) rgba(760060ee) rgba(0052a5ee) 30deg
              # col.active_border = rgba(ffa200ee) rgba(b600a5ee) rgba(760060ee) rgba(0052a5ee) 30deg
              # col.active_border = rgba(ff9300ee) rgba(b600a5ee) rgba(760060ee) rgba(0052a5ee) 30deg
              # col.active_border = rgba(ff9300ee) rgba(6f004eee) rgba(6f004eee) rgba(0052a5ee) 30deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) 30deg
              # col.active_border = rgba(ff9300ee) rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) rgba(0052a5ee) rgba(0052a5ee) rgba(008c41ee) 30deg
              # col.active_border = rgba(ff9300ee) rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) rgba(0052a5ee) rgba(0052a5ee) rgba(04bf5bee) 30deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) rgba(0052a5ee) rgba(04bf5bee) 242deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) rgba(0052a5ee) rgba(00a64dee) 242deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) rgba(0052a5ee) rgba(00b849ee) 242deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) rgba(0091ffee) 242deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) 242deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(ff9300ee) rgba(8f0064ee) 242deg
              # col.active_border = rgba(ff9300ee) rgba(8f0064ee) 242deg
              col.active_border = rgba(ff9300ee) rgba(8f0064ee) rgba(8f0064ee) rgba(8f0064ee) rgba(0052a5ee) 242deg
              # col.active_border = rgba(2cc966ee)

              # col.active_border = rgba(007621ee)

              # col.inactive_border = rgba(595959aa)
              col.inactive_border = rgba(393939ff)

              layout = dwindle

              cursor_inactive_timeout = 3

              # resize_on_border = true
          }

          decoration {
              rounding = 10
              blur {
                  enabled = true
                  size = 3
                  passes = 1
              }
              drop_shadow = false
              shadow_range = 20
              shadow_render_power = 50
              col.shadow = rgba(1a1a1aee)
          }

          animations {
              enabled = yes

              bezier = windows, 0.05, 0.9, 0.1, 1.05
              animation = windows, 1, 7, windows
              animation = windowsOut, 1, 7, default, popin 80%
              animation = border, 1, 10, default
              animation = borderangle, 1, 8, default
              animation = fade, 1, 7, default
              animation = workspaces, 1, 6, default

              bezier = liner, 0, 0, 1, 1
              animation = borderangle, 1, 400, liner, loop
              # animation = borderangle, 1, 200, liner, loop
              # animation = borderangle, 1, 1000, liner, loop
          }

          dwindle {
              pseudotile = yes
              preserve_split = yes
          }

          master {
              new_is_master = true
          }

          gestures {
              workspace_swipe = off
          }

          misc {
              disable_hyprland_logo = true
              disable_splash_rendering = true
              background_color = 0x161616
          }

          exec-once = nu ~/.dotfiles/startup/main.nu
          exec-once = waybar

          $mainMod = SUPER

          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          bind = $mainMod, page_up, workspace, m-1
          bind = $mainMod, page_down, workspace, m+1

          bind = $mainMod, mouse_down, workspace, m+1
          bind = $mainMod, mouse_up, workspace, m-1

          bind = $mainMod, Q, killactive
          bind = $mainMod, M, fullscreen
          bind = $mainMod, G, togglefloating
          bind = $mainMod, O, togglesplit
          bind = $mainMod, S, pseudo
          bind = $mainMod, F, fakefullscreen

          bindm = $mainMod, mouse:273, resizewindow

          binde = $mainMod CONTROL SHIFT, right, resizeactive, 20 0
          binde = $mainMod CONTROL SHIFT, left, resizeactive, -20 0
          binde = $mainMod CONTROL SHIFT, up, resizeactive, 0 -20
          binde = $mainMod CONTROL SHIFT, down, resizeactive, 0 20

          bindm = $mainMod, mouse:272, movewindow

          bind = $mainMod SHIFT, right, movewindow, r
          bind = $mainMod SHIFT, left, movewindow, l
          bind = $mainMod SHIFT, up, movewindow, u
          bind = $mainMod SHIFT, down, movewindow, d

          bind = $mainMod SHIFT, page_up, movetoworkspace, r-1
          bind = $mainMod SHIFT, page_down, movetoworkspace, r+1


          bind = $mainMod, V, exec, clipboard-history

          bind = $mainMod, B, exec, waybar-toggle

          bind = ALT, space, exec, anyrun

          bind = $mainMod, 1, exec, rio
          bind = $mainMod, 2, exec, code
          bind = $mainMod, 3, exec, firefox
          bind = $mainMod, 4, exec, nautilus --new-window
          bind = $mainMod, 5, exec, Enpass
          bind = $mainMod, 6, exec, wezterm
          bind = $mainMod, 7, exec, spotify
          bind = $mainMod, 8, exec, beeper
          # bind = $mainMod, 9, exec,
          # bind = $mainMod, 0, exec,

          bind = $mainMod SHIFT, Q, exit
          bind = $mainMod SHIFT, R, forcerendererreload
          debug {
              disable_logs = false
          }
        '';
      };
    }) ).contents).home-manager.users.timon.wayland.windowManager.hyprland {}
  );
}
