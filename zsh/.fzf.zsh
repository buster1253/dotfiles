#!/bin/bash
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/petter/.fzf/bin* ]]; then
  export PATH="$PATH:/home/petter/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/petter/.fzf/shell/completion.zsh" 2> /dev/null

pv() {
	grep $@|sed -n 's/\([^:]\+\):\([0-9]\+\):/\1\t\2\t/p'|fzf --preview "tail +{2} {1}" --height 100% --bind "enter:execute(vim -u ~/.config/vimrc {1} +{2} < /dev/tty)"
}
# Key bindings
# ------------
source "/home/petter/.fzf/shell/key-bindings.zsh"

