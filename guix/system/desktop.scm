(use-modules (system base)
             (gnu))

(operating-system
  (inherit %base-operating-system)
  (host-name "desktop")

  (mapped-devices
    (list (mapped-device
            (source (uuid ""))
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
             (device (uuid "" 'fat32))
             (type "vfat"))
           %base-file-systems))

  (swap-devices
    (list (swap-space (target "/swapfile")))))
