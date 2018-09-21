#!/bin/bash
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/petter/.fzf/bin* ]]; then
  export PATH="$PATH:/home/petter/.fzf/bin"
fi

## requirements
# hightlight http://www.andre-simon.de/doku/highlight/en/highlight.php

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/petter/.fzf/shell/completion.zsh" 2> /dev/null

gv() {
	grep $@|sed -n 's/\([^.]\+\).\([a-Z]*\)[.orig]\?:\([0-9]\+\)/\1\t\2\t\3\t/p'|fzf --preview 'cat {1}.{2} | highlight --force -S {2} -O ansi ' --height 100% --bind "enter:execute(vim -u ~/.config/vimrc {1}.{2} +{3} < /dev/tty)"
}
pv() {
	grep $@ \
		| sed -n 's/\([^.]\+\).\([a-Z]*\)[.orig]\?:\([0-9]\+\)/\1\t\2\t\3\t/p'\
		| fzf \
			--preview 'LN={3};TOP=$(($LN-10));CTOP=$(($LN-1));BOT=$(($LN+40));CBOT=$(($LN+1)) 
				tail +{3} {1}.{2} | highlight --force -S {2} -O ansi'\
			--height 100%\
			--bind "enter:execute(vim -u ~/.config/vimrc {1}.{2} +{3} < /dev/tty)"
}
# Key bindings
# ------------
source "/home/petter/.fzf/shell/key-bindings.zsh"

