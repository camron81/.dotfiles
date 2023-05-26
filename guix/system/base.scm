(define-module (system base)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(use-service-modules desktop xorg)
(use-package-modules certs ncurses version-control vim)

(define-public %base-system-services
  (services
    (modify-services %desktop-services
         (delete gdm-service-type)
         (guix-service-type config =>
                            (guix-configuration
                              (inherit config)
                              (substitute-urls
                                (cons* "https://substitutes.nonguix.org"
                                       %default-substitute-urls))
                              (authorized-keys
                                (cons* (local-file "../signing-key.pub")
                                       %default-authorized-guix-keys)))))))

(define-public %base-operating-system
  (operating-system
    (host-name "guix")
    (timezone "Europe/London")
    (locale "en_GB.utf8")
    (keyboard-layout (keyboard-layout "gb"))

    (kernel linux)
    ; Limit these to their minimal neceassary includes...
    (initrd microcode-initrd)
    (firmware (list linux-firmware))

    (bootloader
      (bootloader-configuration
        (bootloader grub-efi-bootloader)
        (targets '("/boot/efi"))
        (keyboard-layout keyboard-layout)
        (timeout 3)))

    (file-systems '())

    (users (cons* 
             (user-account
               (name "ethan")
               (group "users")
               (home-directory "/home/ethan")
               (supplementary-groups '("wheel" "netdev" "audio" "video")))
             %base-user-accounts))
    ; Create power group and edit sudoers file to make shutdown runable by users...

    (services %base-system-services)
   
    (packages (cons* 
                git
                ncurses
                neovim
                nss-certs
                %base-packages))

    (skeletons '())

    (name-service-switch %mdns-host-lookup-nss)))
