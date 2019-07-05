#!/bin/bash

source pkgs

sudo pacman -S ${PKGS_PAC[@]}

yay -S ${PKGS_YAY[@]}


## tmux
mkdir $XDG_CONFIG_HOME/tmux/plugins
git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm

ln -s $XDG_CONFIG_HOME/tmux/tmux.conf $HOME/.tmux.conf

echo "Use prefix - I to install tmux plugins"
