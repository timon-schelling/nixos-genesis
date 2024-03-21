
def dotfiles-desktop-gnome-keybindings-save [] {
    dconf dump '/org/gnome/desktop/wm/keybindings/' | save -f ~/.dotfiles/desktop/gnome/keybindings/general.dconf
    dconf dump '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/' | save -f ~/.dotfiles/desktop/gnome/keybindings/custom-values.dconf
    dconf read '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings' | save -f ~/.dotfiles/desktop/gnome/keybindings/custom-keys.dconf
}

def dotfiles-desktop-gnome-keybindings-load [] {
    dconf reset -f '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/'
    dconf reset -f '/org/gnome/desktop/wm/keybindings/'
    open ~/.dotfiles/desktop/gnome/keybindings/general.dconf | dconf load '/org/gnome/desktop/wm/keybindings/'
    open ~/.dotfiles/desktop/gnome/keybindings/custom-values.dconf | dconf load '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/'
    dconf write '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings' $'(open ~/.dotfiles/desktop/gnome/keybindings/custom-keys.dconf)'
}
