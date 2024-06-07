#!/bin/zsh

export WAYLAND_DISPLAY=wayland-1
export MOZ_ENABLE_WAYLAND=1
# Fix java GUIs being wonky
export _JAVA_AWT_WM_NONREPARENTING=1
export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock

# go into window manager for tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	SSH_AGENT=$(pgrep ssh-agent)
	if [ -n "$SSH_AGENT" ]; then
		kill "$SSH_AGENT"
	fi
	eval $(ssh-agent)
	unset WAYLAND_DISPLAY
	export XDG_CURRENT_DESKTOP="sway"
	WLR_DRM_NO_MODIFIERS=1 exec sway
fi
