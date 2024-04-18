{ inputs, config, pkgs, libutils, ... }:

{
  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${config.opts.system.platform}.applications
        inputs.anyrun.packages.${config.opts.system.platform}.rink
        inputs.anyrun.packages.${config.opts.system.platform}.symbols
        inputs.anyrun.packages.${config.opts.system.platform}.websearch
      ];
      width = { absolute = 1000; };
      x = { fraction = 0.5; };
      y = { absolute = 30; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = 16;
    };

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 10,
          terminal: Some("wezterm"),
        )
      '';

      "websearch.ron".text = ''
        Config(
          prefix: "?",
          engines: [Google, DuckDuckGo]
        )
      '';

      "symbols.ron".text = ''
        Config(
          prefix: "$",
          symbols: {},
          max_entries: 50,
        )
      '';

      "stdin.ron".text = ''
        Config(
          allow_invalid: false,
          max_entries: 1000000
        )
      '';
    };
  };

  home.packages = [
    (libutils.nuscript.mkScript pkgs "select-ui" ''
      $in | anyrun-select
    '')
    (libutils.nuscript.mkScript pkgs "anyrun-select" ''
      $in | ^anyrun --plugins "${inputs.anyrun.packages.${config.opts.system.platform}.stdin}/lib/libstdin.so" --hide-plugin-info true
    '')
  ];

  programs.anyrun.extraCss = ''
    @define-color primary #00A380;
    @define-color primary #660053;
    @define-color bg_0 #202020;
    @define-color bg_1 #272727;
    @define-color bg_2 #343434;
    @define-color bg_3 #3F3F3F;
    @define-color text_0 #AAAAAA;
    @define-color text_1 #888888;
    @define-color text_2 #666666;
    @define-color text_3 #444444;

    @define-color background @bg_0;
    @define-color foreground @text_0;
    @define-color launcher_border @bg_2;
    @define-color entry_bg @bg_2;
    @define-color entry_border @bg_2;
    @define-color entry_selection @primary;
    @define-color plug_icon_and_label_bg @bg_1;
    @define-color plug_icon_and_label_fg @text_2;
    @define-color result_bg @bg_1;
    @define-color result_selected_bg @bg_2;
    @define-color result_selected_fg @text_0;
    @define-color result_selected_border @bg_2;

    * {
      all: unset;
      font-family: "SF Pro Rounded", RecMonoLinear;
      font-size: 16px;
    }

    box#main {
      background: @background;
      border: 3px solid @launcher_border;
      border-radius: 16px;
      padding: 14px 12px 0px 12px;
      color: @foreground;
    }

    #entry {
      background: @entry_bg;
      border-radius: 12px;
      padding: 10px;
      border: 2px solid @entry_border;
      font-size: 24px;
      min-height: 44px;
    }

    #entry selection {
      background: @entry_selection;
    }

    list#main{
      padding: 10px 0px;
    }

    box > box#plugin.horizontal:first-child {
      border-radius: 12px;
      background: @plug_icon_and_label_bg;
      color: @plug_icon_and_label_fg;
      padding: 16px;
    }

    list#main > row {
      margin: 2px 1px;
    }

    #match.activatable {
      border-radius: 12px;
      background: @result_bg;
      margin: 0px 0px 12px 0px;
      padding: 10px;
      min-height: 44px;
    }

    #match:selected, #match:hover {
      background: @result_selected_bg;
      color: @result_selected_fg;
      border: 2px solid @result_selected_border;
      padding: 8px;
    }

    #match:hover {
      opacity: 0.6;
    }
  '';
}
