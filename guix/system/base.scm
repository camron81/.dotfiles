(define-module (system base))

(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-service-modules dbus desktop networking pm)
(use-package-modules certs linux ncurses terminals version-control vim wm)

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

    (services 
      (append
        (modify-services %base-services
          (delete console-font-service-type)
          (delete mingetty-service-type)
          (login-service-type config =>
                              (login-configuration
                                (inherit config)
                                (motd "")))
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
          (service console-font-service-type
                   (map (lambda (tty)
                          (cons tty %default-console-font))
                        '("tty1" "tty2" "tty3")))

          (service mingetty-service-type
                   (mingetty-configuration (tty "tty1")
                                           (auto-login "ethan")))
          (service mingetty-service-type
                   (mingetty-configuration (tty "tty2")))
          (service mingetty-service-type
                   (mingetty-configuration (tty "tty3")))

          polkit-wheel-service
      
          fontconfig-file-system-service
      
          (service network-manager-service-type)
          (service wpa-supplicant-service-type)
      
          (service polkit-service-type)
          (service elogind-service-type)
          (service dbus-root-service-type)
      
          (service ntp-service-type)
      
          (service tlp-service-type
                   (tlp-configuration (cpu-boost-on-ac? #t)
                                      (wifi-pwr-on-bat? #f)))
          (service thermald-service-type)

          (udev-rules-service 'brightnessctl-udev-rules brightnessctl))))

    (name-service-switch %mdns-host-lookup-nss)))
