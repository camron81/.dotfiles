export GUIX_USER_PROFILES="$HOME/.local/share/guix-profiles"

for p in $GUIX_USER_PROFILES/*; do
    profile=$p/$(basename "$p")
    if [ -f "$profile"/etc/profile ]; then
        GUIX_PROFILE="$profile"
        . "$GUIX_PROFILE"/etc/profile
    fi
    unset profile
done

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

[ -f ~/.bashrc ] && . ~/.bashrc
