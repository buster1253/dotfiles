#!/bin/zsh

export WAYLAND_DISPLAY=wayland-1
export MOZ_ENABLE_WAYLAND=1
# Fix java GUIs being wonky
export _JAVA_AWT_WM_NONREPARENTING=1
export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock

export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM=wayland
# export QT_QPA_PLATFORM=xcb
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway

# go into window manager for tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty5 ]]; then
	SSH_AGENT=$(pgrep ssh-agent)
	if [ -n "$SSH_AGENT" ]; then
		kill "$SSH_AGENT"
	fi
	eval $(ssh-agent)
	unset WAYLAND_DISPLAY
	WLR_DRM_NO_MODIFIERS=1 exec sway --unsupported-gpu
fi
