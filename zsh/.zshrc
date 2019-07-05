export ZPLUG_HOME=$HOME/.config/zplug
export LANG="en_US.UTF-8"
export EDITOR="vim"
export TERMINAL="alacritty"
export MYVIMRC=$HOME/.config/vimrc
export PATH=/usr/local/openresty/bin:$HOME/.cargo/bin:$HOME/.config/bin:$PATH
export FZF_DEFAULT_OPTS='--height 80%'
export XDG_CONFIG_HOME="$HOME/.config"
export ARCHFLAGS="-arch x86_64"

# go into window manager for tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	pgrep ssh-agent || eval $(ssh-agent)
	exec sway
fi

if [ -f /etc/os-release ]; then
	. /etc/os-release
	OS=$NAME
fi

# Install zplug if not installed
[ ! -d ~/.config/zplug ] \
	&& git clone https://github.com/zplug/zplug ~/.config/zplug
source ~/.config/zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load

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

if [ "$OS" = "Arch Linux" ]; then
	source /usr/share/doc/pkgfile/command-not-found.zsh
fi


function powerline_precmd() {
	PS1="$($XDG_CONFIG_HOME/powerline-rs/target/debug/powerline-rs)"
}
precmd_functions+=(powerline_precmd)

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

alias vi='vim'
alias vim='nvim'
alias ls='ls --color=auto'
alias ll='ls -lh'
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
alias wbc='cd ~/projects/ansible/ansible-webcore-compendium/'

alias sshumount='fusermount3 -u'
# Vi mode
bindkey -v

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

#if [[ $TERM == xterm-termite ]]; then
  #. /etc/profile.d/vte.sh
  #__vte_osc7
#fi

if [[ -z "$TMUX" ]]; then
	tmux -2
	tmux set-environment -g SWAYSOCK /run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock
fi

if [ -f /usr/share/nvm/init-nvm.sh ]; then
	source /usr/share/nvm/init-nvm.sh
fi
