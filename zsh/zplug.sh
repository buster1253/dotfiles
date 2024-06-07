#!/bin/zsh

export ZPLUG_HOME=$HOME/.config/zplug

# Install zplug if not installed
[ ! -d ~/.config/zplug ] &&
	git clone https://github.com/zplug/zplug ~/.config/zplug
source ~/.config/zplug/init.zsh

autoload -Uz comipnit
compinit

# plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load

setopt monitor # fixes CTRL-Z with zplug: https://github.ccom/zplug/zplug/issues/322
