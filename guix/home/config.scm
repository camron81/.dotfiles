(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (guix gexp))

; Should you do type checking...?
(define (dotfile-path path)
  (string-append (getenv "HOME")
                 "/.dotfiles/"
                 path))

(define (xdg-config-spec spec)
  (let ((path (car spec))
        (recur
          (cond ((equal? (length spec) 1) #f)
                ((equal? (length spec) 2) (cdr spec)))))
    (list path (local-file (dotfile-path path) #:recursive? recur))))

(define (xdg-config-list specs)
  (map xdg-config-spec specs))

(define bash-profile-file
  (local-file (dotfile-path "bash-profile.sh")))

(define guix-config-files
  (xdg-config-list
    '(("guix/home" #t)
      ("guix/manifests" #t)
      ("guix/system" #t)
      ("guix/channels.scm")
      ("guix/signing-key.pub"))))

(define nvim-config-files
  (xdg-config-list
    '(("nvim/init.lua")
      ("nvim/fnl" #t))))

(define sway-config-files
  (xdg-config-list
    '(("sway/config"))))

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
                             ;nvim-config-files
                             sway-config-files)))))
