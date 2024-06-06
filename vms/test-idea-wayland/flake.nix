{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, microvm }:
    let
      system = "x86_64-linux";
    in {
      apps.${system} = {
        default = self.apps.${system}.vm-test-idea-wayland;
        vm-test-idea-wayland = {
          type = "app";
          program = self.packages.${system}.vm-test-idea-wayland;
        };
      };

      packages.${system} = {
        default = self.packages.${system}.vm-test-idea-wayland;
        vm-test-idea-wayland = self.nixosConfigurations.vm-test-idea-wayland.config.microvm.declaredRunner;
      };

      nixosConfigurations = {
        vm-test-idea-wayland = nixpkgs.lib.nixosSystem (let pkgs = nixpkgs.pkgs; in {
          inherit system;
          modules = [
            microvm.nixosModules.microvm
            {
              microvm = {
                vcpu = 4;
                mem = 4096;
                volumes = [ {
                  mountPoint = "/var";
                  image = "var.img";
                  size = 256;
                } ];
                shares = [ {
                  # use "virtiofs" for MicroVMs that are started by systemd
                  proto = "9p";
                  tag = "ro-store";
                  # a host's /nix/store will be picked up so that no
                  # squashfs/erofs will be built for it.
                  source = "/nix/store";
                  mountPoint = "/nix/.ro-store";
                } ];

                hypervisor = "crosvm";
                graphics.enable = true;
                socket = "vm-control.socket";
              };

              nixpkgs.overlays = [ self.overlay ];

              services.getty.autologinUser = "user";
              users.users.user = {
                password = "";
                group = "user";
                isNormalUser = true;
                extraGroups = [ "wheel" "video" ];
              };
              users.groups.user = {};
              security.sudo = {
                enable = true;
                wheelNeedsPassword = false;
              };

              environment.sessionVariables = {
                WAYLAND_DISPLAY = "wayland-1";
                DISPLAY = ":0";
                QT_QPA_PLATFORM = "wayland"; # Qt Applications
                GDK_BACKEND = "wayland"; # GTK Applications
                XDG_SESSION_TYPE = "wayland"; # Electron Applications
                SDL_VIDEODRIVER = "wayland";
                CLUTTER_BACKEND = "wayland";
              };

              systemd.user.services.wayland-proxy = {
                enable = true;
                description = "Wayland Proxy";
                serviceConfig = with pkgs; {
                  # Environment = "WAYLAND_DISPLAY=wayland-1";
                  ExecStart = "${wayland-proxy-virtwl}/bin/wayland-proxy-virtwl --virtio-gpu --x-display=0 --xwayland-binary=${xwayland}/bin/Xwayland";
                  Restart = "on-failure";
                  RestartSec = 5;
                };
                wantedBy = [ "default.target" ];
              };

              environment.systemPackages = with pkgs; [
                xdg-utils # Required
                jetbrains.idea-community-bin
              ];

              hardware.opengl.enable = true;
            }
          ];
        });
      };
    };
}
