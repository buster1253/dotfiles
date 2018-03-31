# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZPLUG_HOME=/home/petter/.config/zplug
export LANG="en_US.UTF-8"
export EDITOR='nvim'

# Install zplug if not installed
[ ! -d ~/.config/zplug ] && git clone https://github.com/zplug/zplug ~/.config/zplug
source ~/.config/zplug/init.zsh

export FZF_DEFAULT_OPTS='--height 40%'

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Zplug pluggins

zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Load theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh

zplug load


#plugins=(
#  git
#  vi-mode
#)
#source $ZSH/oh-my-zsh.sh


# True colors
export TERM='xterm-termite'

HISTFILE=$HOME/.config/zsh/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Tab completion menu
zstyle ':completion:*' menu select

# Command not found hook
source /usr/share/doc/pkgfile/command-not-found.zsh

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
# DISABLE_LS_COLORS="true"

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

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Termite new terminal in current directory
if [[ $TERM == xterm-termite ]]; then
	. /etc/profile.d/vte.sh
	__vte_osc7
fi

# ICONS
POWERLEVEL9K_LINUX_ICON=
POWERLEVEL9K_HOME_ICON='\Uf015'
POWERLEVEL9K_HOME_SUB_ICON='\Uf07C'
POWERLEVEL9K_FOLDER_ICON='\Uf07b'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

POWERLEVEL9K_VCS_UNSTAGED_ICON='\Uf06a'
POWERLEVEL9K_VCS_UNTRACKED_ICON='\Uf059'
# Prompt settings
# Font
POWERLEVEL9K_MODE="nerdfont-complete"
# doublelined propt
POWERLEVEL9K_PROMPT_ON_NEWLINE=false

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir status vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode history)

alias vi='nvim'
alias vim='nvim'
alias ls='ls --color=auto'
alias pac='sudo pacman'
# Vi mode
bindkey -v

[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
