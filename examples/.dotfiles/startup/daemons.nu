# wayland background daemon
swww init

# mounr personal cloud drive with rclone
sh -c "(setsid sh -c \"rclone --vfs-cache-mode writes mount personal:/ ~/cloud/personal\" &)"
