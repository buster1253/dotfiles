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

# it'd be nice to use -B 10 and highlight the maching line,
# thus giving better insight to the preceding code.
pv() {
	if [ $# -eq 0 ]; then
		return
	elif [ $# -eq 1 ]; then
		2="*"
	fi
	grep -rn $1 --include \*.$2 --exclude=tags \
		| fzf \
			--delimiter=: \
			--preview 'l={2};
				highlight --force {1} -O truecolor --style nord --line-range=$l-$(($l+40))' \
			--height 100% \
			--bind "enter:execute(nvim {1} +{2} < /dev/tty)" \
}

# Key bindings
# ------------
. /usr/share/fzf/key-bindings.zsh
#source "/home/petter/.fzf/shell/key-bindings.zsh"

