# Config
## Installing zsh
1. Install zsh via pacman
2. Edit ~/.zshenv:
```
ZDOTDIR=/path/to/where/you/want/.zshrc
```
1. Move config files
2. Enjoy


## Keymap
```
~/.xinitrc
[[ -f ~/path/to/key_map ]] && xmodmap ~/path/to/key_map
```
