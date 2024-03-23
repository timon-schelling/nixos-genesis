{ config, pkgs, inputs, ... }:

{
  opts.user.state.folders = [
    ".mozilla/firefox/main"
    # ".cache/mozilla"
  ];

  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
      DefaultDownloadDirectory = "~/tmp";

      Preferences = {
        "browser.contentblocking.category" = "strict";
        "browser.disableResetPrompt" = true;
        "browser.download.panel.shown" = true;
        "browser.formfill.enable" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.search.suggest.enabled.private" = false;
        "browser.search.suggest.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.topsites.contile.enabled" = false;
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.suggest.searches" = false;
        "dom.security.https_only_mode" = true;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "extensions.InstallTrigger.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.disabled" = true;
        "full-screen-api.ignore-widgets" = true;
        "general.smoothScroll" = true;
        "identity.fxaccounts.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-vpx.enabled" = true;
        "network.allow-experiments" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.partition.network_state.ocsp_cache" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = false;
        "signon.rememberSignons" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "widget.use-xdg-desktop-portal.file-picker" = true;
        "widget.use-xdg-desktop-portal.location" = true;
        "widget.use-xdg-desktop-portal.mime-handler" = true;
        "widget.use-xdg-desktop-portal.open-uri" = true;
        "widget.use-xdg-desktop-portal.settings" = true;
      };

      ExtensionSettings = with builtins;
        let extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "force_installed";
          };
        };
        in listToAttrs [
          (extension "perfectdarktheme" "")
          (extension "darkreader" "addon@darkreader.org")
          # (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
          # (extension "uborigin" "uBlock0@raymondhill.net")
          # (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
        ];
        # To add additional extensions,find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # install it in firefox, then go to about:support#addons, or
        # download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
    };

    profiles.main = {
      name = "main";
      extraConfig = ''

      '';
      userChrome = ''

        :root{--in-content-bg-dark:rgb(35, 35, 35);}

        .titlebar-buttonbox-container{ display:none }

        @-moz-document plain-text-document(), media-document(all) {
            :root {
                background-color: var(--in-content-bg-dark) !important;
            }
            body:not([style*="background"], [class], [id]) {
                background-color: transparent !important;
            }
        }
        @-moz-document regexp("view-source:.*") {
            :root,
            body {
                background-color: var(--in-content-bg-dark);
            }
        }
        @-moz-document url-prefix("about:debugging") {
            :root {
                --box-background: var(--in-content-bg-dark) !important;
            }
        }
        @-moz-document url-prefix("about:reader") {
            body.dark {
                --main-background: var(--in-content-bg-dark) !important;
                --tooltip-background: color-mix(in srgb, black 40%, var(--in-content-bg-dark)) !important;
            }
        }

        @-moz-document regexp("^(about:|chrome:|moz-extension:).*") {
            html:not([role="dialog"]),
            html:not([role="dialog"]) *,
            html:not([role="dialog"]) body.activity-stream,
            window:not([chromehidden]),
            window:not([chromehidden]) > dialog {
                --in-content-page-background: hsl(270, 3%, 12%) !important;
                --newtab-background-color: var(--in-content-page-background) !important;
            }
        }
      '';
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@no"];
          };
          "Home Manager" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = ["@hm"];
          };
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };
    };
  };
}
