(define-module (system base)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(use-service-modules desktop xorg)
(use-package-modules certs ncurses version-control vim)

(define backlight-udev-rule
  (udev-rule
    "90-backlight.rules"
    (string-append "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                   "RUN+=\"/run/current-system/profile/bin/chgrp video /sys/class/backlight/%k/brightness\""
                   "\n"
                   "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                   "RUN+=\"/run/current-system/profile/bin/chmod g+w /sys/class/backlight/%k/brightness\"")))

(define-public %base-system-services
    (modify-services %desktop-services
         (delete gdm-service-type)
         (udev-service-type config =>
                            (udev-configuration
                              (inherit config)
                              (rules (cons backlight-udev-rule
                                           (udev-configuration-rules config)))))
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
                                (cons* (local-file "../signing-key.pub")
                                       %default-authorized-guix-keys))))))

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
        (targets '("/boot/efi"))
        (keyboard-layout keyboard-layout)
        (timeout 2)))

    (file-systems '())

    (users (cons* 
             (user-account
               (name "ethan")
               (group "users")
               (home-directory "/home/ethan")
               (supplementary-groups 
                 '("wheel" "netdev" "audio" "video")))
             %base-user-accounts))

    (services %base-system-services)
   
    (packages (cons* 
                git
                ncurses
                neovim
                nss-certs
                %base-packages))

    (name-service-switch %mdns-host-lookup-nss)))
