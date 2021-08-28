#!/usr/bin/env bash


WINDOW_PANES="$(tmux display -p "#{window_panes}")"
BASE_IDX=${BASE_IDX:-"$(tmux display -p "#{pane-base-index}")"}
IS_VIM="tmux display -p '#{pane_current_command}' | rg 'nvim'"
TARGET_FILE="${DOTBARE_TREE}/$1" 


function nvrm(){
  nvim-ctrl ":edit $TARGET_FILE" || nvim "$TARGET_FILE"
}

nvrm "$1"
