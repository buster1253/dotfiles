#!/usr/bin/env zsh

if [[ -z $XDG_RUNTIME_DIR ]]; then
    XDG_RUNTIME_DIR="$HOME/.local/XDG_RUNTIME_DIR"
fi

if [[ ! -d $XDG_RUNTIME_DIR ]]; then
    mkdir -p $XDG_RUNTIME_DIR
fi

if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi

if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
  source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
