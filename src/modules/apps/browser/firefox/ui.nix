{
  currentVersion = 20;
  dirtyAreaCache = [
    "unified-extensions-area"
    "nav-bar"
    "toolbar-menubar"
    "TabsToolbar"
    "PersonalToolbar"
  ];
  newElementCount = 4;
  placements = {
    PersonalToolbar = [ "import-button" "personal-bookmarks" ];
    TabsToolbar = [ "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
    nav-bar = [
      "back-button"
      "forward-button"
      "stop-reload-button"
      "urlbar-container"
      "downloads-button"
      "fxa-toolbar-menu-button"
      "reset-pbm-toolbar-button"
      "unified-extensions-button"
    ];
    toolbar-menubar = [ "menubar-items" ];
    unified-extensions-area = [
      "addon_darkreader_org-browser-action"
      "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
    ];
    widget-overflow-fixed-list = [ ];
  };
  seen = [
    "addon_darkreader_org-browser-action"
    "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
    "developer-button"
  ];
}
