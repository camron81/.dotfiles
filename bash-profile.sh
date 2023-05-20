for p in $GUIX_USER_PROFILES/*; do
	profile=$p/$(basename "$p")
	if [ -f "$profile"/etc/profile ]; then
		GUIX_PROFILE="$profile"
		. "$GUIX_PROFILE"/etc/profile
	fi
	unset profile
done

[ "$(tty)" = "/dev/tty1" ] && exec sway
