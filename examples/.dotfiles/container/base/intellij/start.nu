def build [image: string] {
    cd $env.FILE_PWD
    podman build -t $image .
}

def ask_build [image: string] {
    if (["no", "yes"] | input list "build image?") == "yes" {
        build $image
    }
}

def create [image: string, container: string] {
    ( podman run
        -e DISPLAY
        --net=host
        -v $"($env.XDG_RUNTIME_DIR)/($env.WAYLAND_DISPLAY):/tmp/($env.WAYLAND_DISPLAY):ro"
        -e $"WAYLAND_DISPLAY=/tmp/($env.WAYLAND_DISPLAY)"
        -v $"(($env.DBUS_SESSION_BUS_ADDRESS | split row "=").1):/tmp/dbus.socket:ro"
        -e $"DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/dbus.socket"
        -v $"(($env.DBUS_SESSION_BUS_ADDRESS | split row "=").1):/run/dbus/system_bus_socket"
        -e XDG_RUNTIME_DIR=/tmp
        -v /run/user/1000/pipewire-0:/tmp/pipewire-0
        -v $"/run/user/(id -u)/podman/podman.sock:/tmp/podman/podman.sock"
        -v $"/run/user/(id -u)/podman/podman.sock:/var/run/docker.sock"
        --userns keep-id
        --ipc=host
        --security-opt "label=disabled"
        -v $"(pwd):/workspace"
        --workdir "/workspace"
        --name $container
        -d
        $image
    )
}

def restart [container: string] {
    podman restart $container
}

def stop [container: string] {
    podman stop $container
}

def remove [container: string] {
    podman rm -f $container
}

let image = "containe-intellij"
let container = $"($image)(pwd | str replace -a "/" "-")"

let container_exists = $container in (podman ps -a --format "{{.Names}}" | lines)

mut options = ["cancel"] | append (
    if $container_exists {
        ["restart", "recreate", "stop", "remove"]
    } else {
        ["create"]
    }
)

let action = ($options | input list "action")


if $action == "cancel" {
    exit 0
}

if $action == "create" {
    ask_build $image
    create $image $container
}

if $action == "restart" {
    restart $container
}

if $action == "recreate" {
    ask_build $image
    remove $container
    create $image $container
}

if $action == "stop" {
    stop $container
}

if $action == "remove" {
    remove $container
}
