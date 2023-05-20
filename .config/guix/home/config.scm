(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (guix gexp)
             (srfi srfi-98))

(define bash-profile-path
  (string-append
     (get-environment-variable "HOME")
     "/.dotfiles/bash-profile.sh"))

(home-environment 
  (services 
    (list 
      ; $GUIX_USER_PROFILES needs set before .bash_profile is sourced
      (simple-service 'guix-user-profile-env-var-service
                      home-environment-variables-service-type
                      '(("GUIX_USER_PROFILES" . "$XDG_DATA_HOME/guix-profiles")))
      (service home-bash-service-type
          (home-bash-configuration
            (aliases
             '(("cp" . "cp -riv")
               ("mv" . "mv -iv")
               ("rm" . "rm -iv")))
           (bash-profile (list (local-file bash-profile-path))))))))
