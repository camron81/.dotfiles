(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-package-modules certs nano version-control)

(use-service-modules networking)

(operating-system
  (host-name "guix-desktop")
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

  (mapped-devices
    (list (mapped-device
            (source (uuid ""))
            (target "cryptroot")
            (type luks-device-mapping))))

  (file-systems
    (cons* (file-system
             (mount-point "/boot/efi")
             (device (uuid "" 'fat32))
             (type "vfat"))
           (file-system
             (mount-point "/")
             (device "/dev/mapper/cryptroot")
             (type "ext4") ; Do you want to use an alternative fs??
             (dependencies mapped-devices))
           %base-file-systems))

  (swap-devices
    (list (swap-space
            (target "/swapfile"))))

  (users
    (cons* (user-account
             (name "ethan")
             (group "users")
             (home-directory "/home/ethan")
             (supplementary-groups '("wheel" "netdev" "audio" "video")))
           %base-user-accounts))

  (packages (cons* git nano nss-certs %base-packages))

  (services
   (cons*
     (service dhcp-client-service-type)
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
