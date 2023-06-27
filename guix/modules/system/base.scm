(define-module (system base)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (guix channels)
  #:use-module (guix inferior)
  #:use-module (system security))

(use-package-modules 
  certs 
  linux 
  version-control 
  wm)

(use-service-modules 
  dbus 
  desktop 
  networking 
  pm)

(define (autologin-to-tty config tty user)
  (if (string=? tty (mingetty-configuration-tty config))
    (mingetty-configuration
      (inherit config)
      (auto-login user))
    config))

(define %inferior-linux-kernel
  (let* ((locked-channels
           (list (channel 
                   (name 'guix)
                   (url "https://git.savannah.gnu.org/git/guix.git")
                   (commit "384381f0f900af17c9ec703ebe35b8b3445750f3"))
                 (channel 
                   (name 'nonguix)
                   (url "https://gitlab.com/nonguix/nonguix")
                   (commit "e5fdf073690dc410aa9f6f30515d5cfb61b373df"))))
         (inferior (inferior-for-channels locked-channels)))
    (car (lookup-inferior-packages inferior "linux" "6.3.7"))))

(define %authorized-key-nonguix
  (plain-file "nonguix.pub" 
              "
              (public-key 
                (ecc 
                  (curve Ed25519) 
                  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))

(define-public %base-operating-system
  (operating-system
    (host-name "")
    (timezone "Europe/London")
    (locale "en_GB.utf8")
    (keyboard-layout (keyboard-layout "gb"))

    (kernel %inferior-linux-kernel) 
    (kernel-arguments %secure-kernel-arguments)
    (kernel-loadable-modules '())

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

    (packages (append
                (list brightnessctl
                      git
                      nss-certs
                      sway
                      swaybg
                      swayidle)
                %base-packages))

    (services 
      (cons*
        polkit-wheel-service
      
        fontconfig-file-system-service
      
        (service network-manager-service-type)
        (service wpa-supplicant-service-type)

        (service polkit-service-type)
        (service elogind-service-type)
        (service dbus-root-service-type)

        (service ntp-service-type) ; Should be replaced..

        (service tlp-service-type
          (tlp-configuration (cpu-boost-on-ac? #t)
                             (wifi-pwr-on-bat? #f)))
        (service thermald-service-type)

        (udev-rules-service 'brightnessctl-udev-rules brightnessctl)
        
        (modify-services %secure-base-services
          (login-service-type config =>
                              (login-configuration
                                (inherit config)
                                (motd "")))
          (mingetty-service-type config =>
                                 (autologin-to-tty
                                   config "tty1" "ethan"))
          (guix-service-type config =>
                             (guix-configuration
                               (inherit config)
                               (substitute-urls
                                 (cons* "https://substitutes.nonguix.org"
                                        %default-substitute-urls))
                               (authorized-keys
                                 (cons* %authorized-key-nonguix 
                                        %default-authorized-guix-keys)))))))
      
    (name-service-switch %mdns-host-lookup-nss)))

%secure-base-services
