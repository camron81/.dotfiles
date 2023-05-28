for p in $GUIX_USER_PROFILES/*; do
	profile=$p/$(basename "$p")
	if [ -f "$profile"/etc/profile ]; then
		GUIX_PROFILE="$profile"
		. "$GUIX_PROFILE"/etc/profile
	fi
	unset profile
done

if [ "$(tty)" = "/dev/tty1" ] && [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    exec sway
fi
