(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (gnu packages gnome)
             (gnu packages gnome-xyz)
             (guix gexp)
             (gextra packages fonts))

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

(define bashrc-file
  (local-file
    (dotfiles-path-append "bashrc.sh")))

(define config-files
  (map dotfiles-symlink 
       '(("foot/foot.ini")
         ("guix/channels.scm")
         ("npm/npmrc")
         ;("nvim/init.lua")
         ;("nvim/fnl" #t)
         ("sway/config"))))

(home-environment 
  (packages (list
              bibata-cursor-theme
              font-nerd-meslo
              hicolor-icon-theme))

  (services (list 
              (simple-service 'setup-environment-variables-service
                              home-environment-variables-service-type
                              `(("GUIX_USER_PROFILES" . "$XDG_DATA_HOME/guix-profiles")
                                ; default applications
                                ("EDITOR" . "nvim")
                                ("BROWSER" . "firefox")
                                ("EXA_ICON_SPACING" . "2")
                                ; xdg base directory specification
                                ("HISTFILE" . "$XDG_STATE_HOME/bash/history")
                                ("HISTIGNORE" . "clear:exit")
                                ("CARGO_HOME" . "$XDG_DATA_HOME/cargo")
                                ("NPM_CONFIG_USERCONFIG" . "$XDG_CONFIG_HOME/npm/npmrc")))

              (service home-bash-service-type
                  (home-bash-configuration
                    (guix-defaults? #f)
                    (bash-profile 
                      (list bash-profile-file))
                    (bashrc 
                      (list bashrc-file))
                    (aliases
                     '(("cp" . "cp -riv")
                       ("mv" . "mv -iv")
                       ("rm" . "rm -iv")
                       ("mkdir" . "mkdir -vp")
                       ("grep" . "grep --color")
                       ("ls" . "exa --icons --group-directories-first")))))

              (simple-service 'xdg-config-files-service
                              home-xdg-configuration-files-service-type
                            config-files))))
