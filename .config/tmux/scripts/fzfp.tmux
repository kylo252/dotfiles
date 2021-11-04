#!/usr/bin/env bash

function _tmux_split() {
  tmux split-window -v -c '#{pane_current_path}' "$1"
}

function open-lsp-log() {
  _tmux_split "lnav ~/.cache/nvim/lsp.log"
}

function open-nvim-log() {
  _tmux_split "lnav ~/.cache/nvim/log"
}

function open-lvim-log() {
  _tmux_split "lnav ~/.cache/nvim/lvim.log"
}

function open-installer-log() {
  _tmux_split "lnav ~/.cache/nvim/lsp-installer.log"
}

declare -a actions=(
  open-lsp-log
  open-nvim-log
  open-lvim-log
  open-installer-log
)

SELECTION=$(
  printf "%s\n" "${actions[@]}" |
    fzf-tmux --exact --exit-0 --delimiter=' ' --reverse --header="select action "
) &&
  "$SELECTION"
