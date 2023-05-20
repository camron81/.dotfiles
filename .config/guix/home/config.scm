(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (guix gexp))

(define bash-profile-text
  "for p in $GUIX_USER_PROFILES/*; do
    profile=$p/$(basename \"$p\")
    if [ -f \"$profile\"/etc/profile ]; then
        GUIX_PROFILE=\"$profile\"
        . \"$GUIX_PROFILE\"/etc/profile
    fi
    unset profile
done

[ \"$(tty)\" = \"/dev/tty1\" ] && exec sway")

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
           (bash-profile (list (plain-file "bash-profile"
                                           bash-profile-text))))))))
