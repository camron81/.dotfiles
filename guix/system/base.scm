(define-module (system base)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(use-service-modules dbus desktop networking pm)
(use-package-modules certs gnome ncurses linux terminals version-control vim wm)

(define-public %base-operating-system
  (operating-system
    (host-name "guix")
    (timezone "Europe/London")
    (locale "en_GB.utf8")
    (keyboard-layout (keyboard-layout "gb"))

    (kernel linux)

    (initrd (lambda (file-systems . rest)
              (apply microcode-initrd file-systems
                     #:initrd base-initrd
                     #:microcode-packages (list amd-microcode)
                     rest)))

    (firmware (cons* amdgpu-firmware
                     atheros-firmware
                     realtek-firmware
                     %base-firmware))

    (bootloader
      (bootloader-configuration
        (bootloader grub-efi-bootloader)
        (targets '("/boot/efi/"))
        (keyboard-layout keyboard-layout)
        (timeout 5)))

    (file-systems '())

    (users (cons*
             (user-account
               (name "ethan")
               (group "users")
               (home-directory "/home/ethan")
               (supplementary-groups
                 '("wheel" "netdev" "audio" "video")))
             %base-user-accounts))

    (packages (cons*
                brightnessctl
                foot
                git
                ncurses
                neovim
                nss-certs
                sway
                swaybg
                swayidle
                %base-packages))

    (services (append
                (modify-services %base-services
                  (login-service-type config =>
                                      (login-configuration
                                        (inherit config)
                                        (motd "")))
                  (mingetty-service-type config =>
                                         (mingetty-configuration
                                           (inherit config)
                                           (auto-login "ethan")))
                  (guix-service-type config =>
                                     (guix-configuration
                                       (inherit config)
                                       (substitute-urls
                                         (cons* "https://substitutes.nonguix.org"
                                                %default-substitute-urls))
                                       (authorized-keys
                                         (cons* (plain-file "nonguix.pub" 
                                                            "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
                                                %default-authorized-guix-keys)))))

                (list
                  (service network-manager-service-type)
                  (service wpa-supplicant-service-type)
                  (simple-service 'network-manager-applet
                                  profile-service-type
                                  (list network-manager-applet))
                  (service modem-manager-service-type)
                  (service usb-modeswitch-service-type)

                  polkit-wheel-service
                  (service polkit-service-type)
                  (service elogind-service-type)
                  (service dbus-root-service-type)

                  (service tlp-service-type
                           (tlp-configuration (cpu-boost-on-ac? #t)))
                  (service thermald-service-type)

                  (service ntp-service-type)

                  fontconfig-file-system-service

                  (udev-rules-service 'pipewire-udev-rules pipewire)
                  (udev-rules-service 'brightnessctl-udev-rules brightnessctl))))

    (name-service-switch %mdns-host-lookup-nss)))
