# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZPLUG_HOME=/home/petter/.config/zplug
export LANG="en_US.UTF-8"
export EDITOR='nvim'
export PATH=/usr/local/openresty/bin:$PATH

# Install zplug if not installed
[ ! -d ~/.config/zplug ] && git clone https://github.com/zplug/zplug ~/.config/zplug
source ~/.config/zplug/init.zsh

export FZF_DEFAULT_OPTS='--height 40%'

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Zplug pluggins

zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Load theme
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug load

# SPACESHIP CONF
# LEFT PROMPT ORDER

SPACESHIP_PROMPT_ORDER=(
	time			# Time stampts section
	user			# Username section
	dir				# Current directory section
	host			# Hostname section
	git
	hg				# Mercurial section (hg_branch	+ hg_status)
	package			# Package version
	node			# Node.js section
	ruby			# Ruby section
	elixir			# Elixir section
	xcode			# Xcode section
	swift			# Swift section
	golang			# Go section
	php				# PHP section
	rust			# Rust section
	haskell			# Haskell Stack section
	julia			# Julia section
	docker			# Docker section
	aws				# Amazon Web Services section
	venv			# virtualenv section
	conda			# conda virtualenv section
	pyenv			# Pyenv section
	dotnet			# .NET section
	ember			# Ember.js section
	kubecontext		# Kubectl context section
	exec_time		# Execution time
	line_sep		# Line break
#	battery			# Battery level and status
#	vi_mode			# Vi-mode indicator
	jobs			# Background jobs indicator
	exit_code		# Exit code section
	char			# Prompt character
)

# RIGHT PROMPT ORDER
SPACESHIP_RPROMPT_ORDER=(
)


# PROMPT
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false

# CHAR
SPACESHIP_CHAR_PREFIX=""
SPACESHIP_CHAR_SUFFIX=""

# USER
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_PREFIX=""

# GIT
SPACESHIP_GIT_SYMBOL=""
SPACESHIP_GIT_BRANCH_PREFIX=""
# WRAP BRANCH & STATUS IN git:(..)
SPACESHIP_GIT_PREFIX='git:('
SPACESHIP_GIT_SUFFIX=")"
SPACESHIP_GIT_BRANCH_SUFFIX=""
# REMOVE [] AROUND STATUS
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""



# True colors
#export TERM='xterm-termite'

HISTFILE=$HOME/.config/zsh/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Tab completion menu
zstyle ':completion:*' menu select

# Command not found hook
source /etc/zsh_command_not_found

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

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

# Termite new terminal in current directory
if [[ $TERM == xterm-termite ]]; then
	. /etc/profile.d/vte-2.91.sh
	__vte_osc7
fi

alias vi='nvim'
alias vim='nvim'
alias ls='ls --color=auto'
alias pac='sudo pacman'
# Vi mode
bindkey -v

[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh
