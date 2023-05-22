(use-modules (templates system)
             (gnu))

(operating-system
  (inherit %base-operating-system)
  (host-name "desktop")

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
    (list (swap-space (target "/swapfile")))))
