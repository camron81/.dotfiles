(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (guix gexp))

; Should you do type checking...?
(define (dotfiles-path-append path)
  (string-append (getenv "HOME") "/.dotfiles/" path))

(define (dotfiles-symlink file-spec)
  (let ((path (car file-spec))
        (recur
          (cond ((equal? (length file-spec) 1) #f)
                ((equal? (length file-spec) 2) (cdr file-spec)))))
    (list path (local-file (dotfiles-path-append path) 
                           #:recursive? recur))))

(define bash-profile-file
  (local-file 
    (dotfiles-path-append "bash-profile.sh")))

(define config-files
  (map dotfiles-symlink '(("guix/channels.scm")
                          ("nvim" #t)
                          ("sway/config"))))

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
                     config-files))))
