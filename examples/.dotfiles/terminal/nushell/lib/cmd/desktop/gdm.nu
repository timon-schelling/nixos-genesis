def desktop-gdm-fix-monitors [] {
    sudo cp ~/.config/monitors.xml ~gdm/.config/monitors.xml
    sudo chown gdm:gdm ~gdm/.config/monitors.xml
}
