(use-modules (templates system)
             (gnu))

(operating-system
  (inherit %base-operating-system)
  (host-name "laptop")

  (mapped-devices
    (list (mapped-device
            (source (uuid "789088cf-334b-4982-b8b4-6a530be11489"))
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
             (device (uuid "763C-CA4D" 'fat32))
             (type "vfat"))
           %base-file-systems))

  (swap-devices
    (list (swap-space (target "/swapfile")))))
