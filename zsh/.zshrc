export LANG="en_US.UTF-8"
export EDITOR="nvim"
export TERMINAL="alacritty"
export MYVIMRC=$HOME/.config/vimrc
export FZF_DEFAULT_OPTS='--height 80%'
export XDG_CONFIG_HOME="$HOME/.config"
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export ANDROID_HOME=/opt/android-sdk/tools
export VISUAL="$EDITOR" # git-issue: https://github.com/dspinellis/git-issue
# for flutter
export CHROME_EXECUTABLE=google-chrome-stable

# set LS_COLORS
if type dircolors > /dev/null; then
  eval $(dircolors)
else
  export LSCOLORS=GxFxCxDxBxegedabagaced
fi

if type jenv > /dev/null; then
  export JAVA_HOME=$(jenv javahome)
fi

# cpu specific
arch=$(uname -m)
if [[ $arch == x86_64* ]]; then
  export ARCHFLAGS="-arch x86_64"
fi

# OS specific
os=$(uname -s)
if [[ $os == "Linux" ]]; then
  source $HOME/.config/zsh/linux.sh
elif [[ $os == "Darwin" ]]; then
  source $HOME/.config/zsh/macos.sh
fi

if [ -f /etc/os-release ]; then
	. /etc/os-release
	OS=$NAME
fi


# Path
paths=( \
    "/opt/cuda/bin"                    \
    "/usr/local/openresty/bin"         \
    "/opt/android-sdk/tools"           \
    "/opt/android-sdk/platform-tools"  \
    "$HOME/.gem/ruby/3.0.0/bin" \
    "$HOME/.local/bin"          \
    "$HOME/petter/.pub-cache/bin"      \
    "$HOME/.cargo/bin"                 \
    "$HOME/go/bin"                     \
    "$HOME/.config/bin"                \
)

for p in ${paths[@]}; do
	if [ -d $p ]; then
		PATH=$p:$PATH
	fi
done

export PATH=$PATH

# if type sqlx > /dev/null; then
#   source $(sqlx completions zsh)
# fi

#source "$HOME/.config/zsh/zplug.sh"
source "$HOME/.config/zsh/zinit.sh"

ZLE_RPROMPT_INDENT=0

# History
HISTFILE=$HOME/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
#setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# reduce esc delay
export KEYTIMEOUT=1


# Tab completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Prompt
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
PROMPT='$("$HOME/.config/prompt-rs/target/release/prompt-rs" --jobs="$JOBS_COUNT")'


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

## GPG (remember to add `use-agent` to gpg.conf)
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

## Aliases
alias vi="$EDITOR"
alias vim="$EDITOR"
#alias nvim="/usr/bin/nvim"
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
alias gb='git branch'
alias gco='git checkout'
alias gbf='gco $(git branch | fzf)'
alias editmodified='git ls-files -m | fzf --bind "enter:become($EDITOR {})" --preview="git diff {} | delta"'

alias sshumount='fusermount3 -u'

if type bat > /dev/null; then
  alias cat='bat --theme Nord'
fi

if type eza > /dev/null; then
  alias ls='eza'
  alias ll='eza -al'
else 
  alias ls='ls'
  alias ll='ls -al'
fi

if type wl-copy > /dev/null; then
  alias cpy='wl-copy -p'
elif type pbcopy > /dev/null; then
  alias cpy='pbcopy'
fi


# zoxide
if type zoxide > /dev/null; then
  source ~/.config/zsh/zoxide.sh
fi

# Vi mode
bindkey -v
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh

# viman() { text=$(man "$@") && echo "$text" | vim -R +":set ft=man" - ; }
# quick search
# rewrite to luakit if anything
# ffs() { firefox --new-tab "https://duckduckgo.com/?q=$*"; }

# rgrep() {
# 	grep -rn $1 | sed -e 's/:\([0-9]*\):/ +\1/'
# }


if [[ -z "$TMUX" ]]; then
	tmux -2
fi

# Node Version manager(nvm)
if [ -f /usr/share/nvm/init-nvm.sh ]; then
	source /usr/share/nvm/init-nvm.sh
fi

# Make zsh fg behave in a usefull manner
fg() {
	if [[ $# -eq 1 && $1 = - ]]; then
		fg %-
	else
		builtin fg "%$@"
	fi
}

proj() {
	cd ~/projects/$1
}

_projlist() {
  inp=$1

  if [[ "$inp" == */ ]]; then
    _dir=~/projects/$inp
    base=""
  elif [[ $inp != "" ]]; then
    _dir=$(dirname ~/projects/$inp)
    base=$(basename $inp)
  else
    _dir=~/projects
    base=""
  fi

  _reply=($(find $_dir  -maxdepth 1  -mindepth 1 -type d -name "$base*" | sed -E 's/.*projects\///'))

  if [[ ${#_reply[@]} == 1 ]]; then
    _dir=$_dir/$(basename $_reply)/

    base=""
  fi
  reply=($(find $_dir -maxdepth 1 -mindepth 1 -type d -name "$base*" | sed -E 's/.*projects\///'))
}

myip() {
  curl -4 icanhazip.com
}

compctl -K _projlist proj
