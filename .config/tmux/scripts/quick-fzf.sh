#!/usr/bin/env bash

TMUX_FZF_DIR="$XDG_DATA_HOME/tmux/plugins/tmux-fzf"
TMUX_FZF_ORDER="keybinding|clipboard|process|command"
TMUX_FZF_MENU="test\nfzf\n"

# TMUX_FZF_SECONDARY_KEY=
bind-key "c-t" run-shell "$TMUX_FZF_DIR/main.sh"
# tmux bind-key "$TMUX_FZF_LAUNCH_KEY" run-shell -b "$CURRENT_DIR/main.sh"
