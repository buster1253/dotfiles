#!/bin/sh

swaymsg output \'Chimei Innolux Corporation 0x14C9 0x00000000\' dpms off disable
swaymsg output \'Goldstar Company Ltd LG Ultra HD 0x000017A1\' mode 3840x2160 \
	pos 1920 0
swaymsg output \'Synaptics Inc Non-PnP 0x00000101\' mode 1920x1080 \
	pos 0 1080
swaymsg output \'Unknown BenQ XL2420G JCE00573SL0\' mode 1920x1080 \
	pos 0 0

swaymsg workspace 1
swaymsg move workspace to \'Goldstar Company Ltd LG Ultra HD 0x000017A1\'

swaymsg workspace 2
swaymsg move workspace to \'Unknown BenQ XL2420G JCE00573SL0\'

swaymsg workspace 3
swaymsg move workspace to \'Synaptics Inc Non-PnP 0x00000101\'
