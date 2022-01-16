export ZPLUG_HOME=$HOME/.config/zplug
export LANG="en_US.UTF-8"
export EDITOR="nvim"
export TERMINAL="alacritty"
export MYVIMRC=$HOME/.config/vimrc
export FZF_DEFAULT_OPTS='--height 80%'
export XDG_CONFIG_HOME="$HOME/.config"
export ARCHFLAGS="-arch x86_64"
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export WAYLAND_DISPLAY=wayland-1
export MOZ_ENABLE_WAYLAND=1
export ANDROID_HOME=/opt/android-sdk/tools
export VISUAL="$EDITOR" # git-issue: https://github.com/dspinellis/git-issue

# Fix java GUIs being wonky
export _JAVA_AWT_WM_NONREPARENTING=1

# Path
PATH=$HOME/.cargo/bin:$PATH              # cargo
PATH=$HOME/.config/bin:$PATH             # quality of life scripts

if [ -d /opt/cuda/bin ]; then
	PATH=/opt/cuda/bin:$PATH             # cuda
fi

if [ -d /usr/local/openresty/bin ]; then # openresty
	PATH=/usr/local/openresty/bin:$PATH
fi

if [ -d /opt/android-sdk/tools ]; then
	PATH=/opt/android-sdk/tools:$PATH
	PATH=/opt/android-sdk/platform-tools:$PATH
fi

export PATH=$PATH


# go into window manager for tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	SSH_AGENT=$(pgrep ssh-agent)
	if [ -n "$SSH_AGENT" ]; then
		kill "$SSH_AGENT"
	fi
	eval $(ssh-agent)
	unset WAYLAND_DISPLAY
	WLR_DRM_NO_MODIFIERS=1 exec sway
fi

if [ -f /etc/os-release ]; then
	. /etc/os-release
	OS=$NAME
fi

# Install zplug if not installed
[ ! -d ~/.config/zplug ] \
	&& git clone https://github.com/zplug/zplug ~/.config/zplug
source ~/.config/zplug/init.zsh

autoload -Uz comipnit
compinit

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load
setopt monitor

ZLE_RPROMPT_INDENT=0
HISTFILE=$HOME/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

# reduce esc delay
export KEYTIMEOUT=1

# Tab completion menu
zstyle ':completion:*' menu select

#if [ "$OS" = "Arch Linux" ]; then
	#source /usr/share/doc/pkgfile/command-not-found.zsh
#fi


zmodload zsh/parameter
function powerline_precmd() {
    JOBS_COUNT=${#jobstates}
}
(( ! ${+precmd_functions} )) && precmd_functions=()
if [[ -z ${precmd_functions[(re)powerline_precmd]} ]]; then
	precmd_functions+=(powerline_precmd)
fi
precmd_functions+=(powerline_precmd)
setopt promptsubst
PROMPT='$("/home/petter/.config/prompt-rs/target/release/prompt-rs" --jobs="$JOBS_COUNT")'

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
#DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#
## GPG (remember to add `use-agent` to gpg.conf)
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

## Aliases
alias vi='vim'
alias vim='nvim'
alias nvim='nvim'
#alias ls='ls --color=auto'
#alias ll='ls -lh'
alias pac='sudo pacman'
alias lua='rlwrap luajit'
alias pdf='zathura'
# git
alias ga='git add'
alias gd='git diff'
alias gc='git commit'
alias gp='git pull'
alias pg='git push'
alias gs='git status'
alias gl='git log'
alias gco='git checkout'
# ez dirs
alias awc='cd ~/projects/webcore/ansible-webcore-compendium/'
alias master='cd ~/school/ntnu/A2021/master/'
alias school='cd ~/school/ntnu/A2021'
#
alias cat='bat --theme Nord'
alias ls='exa'
alias ll='exa -al'
alias cpy='wl-copy -p'
alias sshumount='fusermount3 -u'

# Vi mode
bindkey -v
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# viman() { text=$(man "$@") && echo "$text" | vim -R +":set ft=man" - ; }
# quick search
# rewrite to luakit if anything
# ffs() { firefox --new-tab "https://duckduckgo.com/?q=$*"; }

rgrep() {
	grep -rn $1 | sed -e 's/:\([0-9]*\):/ +\1/'
}

fg() {
	if [[ $# -eq 1 && $1 = - ]]; then
		fg %-
	else
		builtin fg "%$@"
	fi
}

[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh


export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
if [[ -z "$TMUX" ]]; then
	tmux -2
fi

if [ -f /usr/share/nvm/init-nvm.sh ]; then
	source /usr/share/nvm/init-nvm.sh
fi


proj() {
	cd ~/projects/$1
}
_projlist() {
	reply=($(find ~/projects/ -maxdepth 2 -type d -mindepth 2 | sed -E 's/.*projects\///'))
}
compctl -K _projlist proj
