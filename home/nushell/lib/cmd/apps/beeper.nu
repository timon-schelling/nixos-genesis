def beeper [] {
    /opt/beeper/beeper.AppImage
}

def beeper-kill [] {
    pkill -f beeper
}

def beeper-update [] {
    sudo wget https://download.beeper.com/linux/appImage/x64 -O /opt/beeper/beeper.AppImage
    sudo sh -c "chmod +x /opt/beeper/beeper.AppImage"
}

def beeper-patch [] {
    sudo docker build -t localhost/beeper-update-patch ~/.dotfiles/desktop/beeper/patch
    sudo docker run --name beeper-update-patch --rm -v /opt/beeper/beeper.AppImage:/app/appimage localhost/beeper-update-patch
    sudo sh -c "chmod +x /opt/beeper/beeper.AppImage"
}

def beeper-update-and-patch [] {
    beeper-update
    beeper-patch
}

def beeper-kill-update-and-patch [] {
    beeper-kill
    beeper-update
    beeper-patch
}

def beeper-update-from-tmp [] {
    let file = (ls ~/tmp | where name =~ beeper | where name =~ .AppImage | sort-by modified -r | take 1);
    sudo sh -c $"chmod +x ($file.name.0)";
    cp $file.name.0 /opt/beeper/beeper.AppImage
}

def beeper-update-from-tmp-and-patch [] {
    beeper-update-from-tmp
    beeper-patch
}
