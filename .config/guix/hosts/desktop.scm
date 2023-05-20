(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd))

(use-package-modules 
  certs 
  terminals
  version-control
  vim 
  wm
  xdisorg)

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
            (source (uuid "be25cc34-8181-43a4-aef8-03e509829165"))
            (target "cryptroot")
            (type luks-device-mapping))))

  (file-systems
    (cons* (file-system
             (mount-point "/")
             (device "/dev/mapper/cryptroot")
             (type "ext4")
             (dependencies mapped-devices))
           (file-system
             (mount-point "/boot/efi")
             (device (uuid "46E0-A963" 'fat32))
             (type "vfat"))
           %base-file-systems))

  (swap-devices
    (list (swap-space (target "/swapfile"))))

  (users (cons* (user-account
                  (name "ethan")
                  (group "users")
                  (home-directory "/home/ethan")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  (packages (cons* 
              bemenu
              foot
              git 
              neovim
              nss-certs
              sway
              swaybg
              swayidle
              swaylock
              %base-packages))

  (services %my-services)

  (name-service-switch %mdns-host-lookup-nss))

(define %my-services
  (modify-services %desktop-services
    (delete gdm-service-type)
    (guix-service-type config =>
                       (guix-configuration
                         (inherit config)
                         (substitute-urls
                           (cons* "https://substitutes.nonguix.org"
                                  %default-substitute-urls))
                         (authorized-keys
                           (cons* (local-file "./signing-key.pub")
                                  %default-authorized-guix-keys))))))
