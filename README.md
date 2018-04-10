# Config
## Installing zsh
1. Install zsh via pacman
2. Edit ~/.zshenv:
```Bash
ZDOTDIR=/path/to/where/you/want/.zshrc
```
1. Move config files
2. Enjoy


## Keymap
```Bash
~/.xinitrc
[[ -f ~/path/to/key_map ]] && xmodmap ~/path/to/key_map
```

## Pandoc
[Pandoc Bin](https://aur.archlinux.org/packages/pandoc-bin/)  
`pacman -S texlive-core`


## Shit I might forget to install:
* shellcheck(pacman) - Ale Bash linter
