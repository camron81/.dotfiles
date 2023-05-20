(define-module (base-system)
  #:use-module (gnu)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages nano)
  #:use-module (gnu packages version-control)
  #:use-module (gnu services networking)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(define %my-base-services
  (services
    (cons*
      (service-dhcp-client-service-type)
      (modify-services
        %base-services
        (guix-service-type config =>
                           (guix-configuration
                             (inherit config)
                             (substitute-urls
                               (cons* "https://substitutes.nonguix.org"
                                      %default-substitute-urls))
                             (authorized-keys
                               (cons* (local-file "./signing-key.pub")
                                      %default-authorized-guix-keys))))))))

(define-public %base-operating-system
  (operating-system
    (host-name "guix")
    (timezone "Europe/London")
    (locale "en_GB.utf8")
    (keyboard-layout (keyboard-layout "gb"))

    (kernel linux)
    (initrd microcode-initrd)
    (firmware (list linux-firmware))

    (bootloader
      (bootloader-configuration
        (bootloader grub-efi-bootloader)
        (targets '("/boot/efi"))
        (keyboard-layout keyboard-layout)
        (timeout 3)))

    (users (cons* (user-account
                    (name "ethan")
                    (group "users")
                    (home-directory "/home/ethan")
                    (supplementary-groups '("wheel" "netdev" "audio" "video")))
                  %base-user-accounts))
                    

    (packages (cons* git nano nss-certs %base-packages))

    (services %my-base-services)

    (name-service-switch %mdns-host-lookup-nss))) 





    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 
