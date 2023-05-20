(define-module (templates system)
  #:use-module (gnu)
  #:use-module (gnu services desktop)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

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
                                         %default-authorized-guix-keys))))))
   
    (packages (cons* 
                git
                neovim
                nss-certs
                %base-packages))

    (name-service-switch %mdns-host-lookup-nss)))
