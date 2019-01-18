#!/bin/bash
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/petter/.fzf/bin* ]]; then
  export PATH="$PATH:/home/petter/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/petter/.fzf/shell/completion.zsh" 2> /dev/null

# requirements
# hightlight http://www.andre-simon.de/doku/highlight/en/highlight.php
		#| sed -n 's/\([^.]\+\).\([a-Z]*\)[.orig]\?:\([0-9]\+\)/\1\t\2\t\3\t/p'\
pv() {
	grep -rn $@ \
		| sed -n 's/\([^.]\+\).\([a-zA-Z]*\)[.orig]\?:\([0-9]\+\)/\1\t\2\t\3\t/p'\
		| fzf \
			--preview 'tail +{3} {1}.{2} | highlight --force -S {2} -O ansi'\
			--height 100%\
			--bind "enter:execute(vim -u ~/.config/vimrc {1}.{2} +{3} < /dev/tty)"
}

# Key bindings
# ------------
. /usr/share/fzf/key-bindings.zsh
#source "/home/petter/.fzf/shell/key-bindings.zsh"

