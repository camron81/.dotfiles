(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (guix gexp))

(define (dotfile-path path)
  (string-append (getenv "HOME")
                 "/.dotfiles/"
                 path))

(define bash-profile-file
  (local-file (dotfile-path "bash-profile.sh")))

(define guix-config-files
  `(("guix/home" ,(local-file (dotfile-path "guix/home") #:recursive? #t))
    ("guix/manifests" ,(local-file (dotfile-path "guix/manifests") #:recursive? #t))
    ("guix/system" ,(local-file (dotfile-path "guix/system") #:recursive? #t))
    ("guix/templates" ,(local-file (dotfile-path "guix/templates") #:recursive? #t))
    ("guix/channels.scm" ,(local-file (dotfile-path "guix/channels.scm")))
    ("guix/signing-key.pub" ,(local-file (dotfile-path "guix/signing-key.pub")))))

(define nvim-config-files
  `(("nvim/init.lua" ,(local-file (dotfile-path "nvim/init.lua")))
    ("nvim/fnl" ,(local-file (dotfile-path "nvim/fnl") #:recursive? #t))))

(define sway-config-files
  `(("sway/config" ,(local-file (dotfile-path "sway/config")))))

(home-environment 
  (services 
    (list 
      (simple-service 'setup-environment-variables-service
                      home-environment-variables-service-type
                      '(("GUIX_USER_PROFILES" . "$XDG_DATA_HOME/guix-profiles")))
      (service home-bash-service-type
          (home-bash-configuration
            (aliases
             '(("cp" . "cp -riv")
               ("mv" . "mv -iv")
               ("rm" . "rm -iv")))
           (bash-profile (list bash-profile-file))))
     (simple-service 'xdg-config-files-service
                     home-xdg-configuration-files-service-type
                     (append guix-config-files
                             nvim-config-files
                             sway-config-files)))))
