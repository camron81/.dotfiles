(use-modules (gnu home)
             (gnu home services shells)
             (gnu services)
             (guix gexp))

(define load-user-profiles
  "for p in $GUIX_USER_PROFILES/*; do
       profile=$p/$(basename \"$p\")
       if [ -f \"$profile\"/etc/profile ]; then
           GUIX_PROFILE=\"$profile\"
	   . \"$GUIX_PROFILE\"/etc/profile
       fi
       unset profile
   done")

(home-environment 
  (services 
    (list 
       (service home-bash-service-type
         (home-bash-configuration
           (environment-variables
             '(("XDG_CONFIG_HOME" . "$HOME/.config")
               ("XDG_DATA_HOME" . "$HOME/.local/share")
               ("XDG_STATE_HOME" . "$HOME/.local/state")
               ("GUIX_USER_PROFILES" . "$XDG_DATA_HOME/guix-profiles")))
           (aliases
            '(("cp" . "cp -riv")
              ("mv" . "mv -iv")
              ("rm" . "rm -iv")))
          (bashrc
            (list (plain-file "bash_config" load-user-profiles))))))))
