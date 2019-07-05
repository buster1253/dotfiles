#!/bin/sh

swaymsg output \'Unknown 2752Q EWWD2JA000667\' pos 1920 0
swaymsg output \'Acer Technologies P246H LQK0D0158510\' pos 0 0
swaymsg output eDP-1 pos 3840 0

swaymsg workspace 1
swaymsg move workspace to eDP-1

swaymsg workspace 2
swaymsg move workspace to \'Unknown 2752Q EWWD2JA000667\'

swaymsg workspace 3
swaymsg move workspace to \'Acer Technologies P246H LQK0D0158510\'
