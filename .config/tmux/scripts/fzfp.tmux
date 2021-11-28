#!/usr/bin/env bash

function _tmux_lnav_split() {
  local file="$1"
  local file_basedir=echo "$(dirname "$(readlink -m "$file")")"
  tmux split-window -v -c "$file_basedir" "lnav $file"
}

function open-nvim-log() {
  _tmux_lnav_split "$HOME/.cache/nvim/*log*"
}

declare -a actions=(
  open-nvim-log
)

SELECTION=$(
  printf "%s\n" "${actions[@]}" |
    fzf-tmux --exact --exit-0 --delimiter=' ' --reverse --header="select action "
) &&
  "$SELECTION"
