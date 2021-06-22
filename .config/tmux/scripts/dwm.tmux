#!/usr/bin/env bash

WINDOW_PANES="$(tmux display -p "#{window_panes}")"
BASE_IDX=${BASE_IDX:-"$(tmux display -p "#{pane-base-index}")"}

newpane() {
  tmux \
    split-window -t "$BASE_IDX" -c "#{pane_current_path}" \; \
    swap-pane -t "{previous}" -d\; \
    select-layout main-vertical\; \
    resize-pane -t "$BASE_IDX" -x "${FACTOR:-50}"%
}

killpane() {
  if (( WINDOW_PANES > 1)); then
    tmux kill-pane -t :.\; \
         select-layout main-vertical\; \
         resize-pane -t :.1 -x "${FACTOR:-50}"%
  else
    if [ -z "$KILLLAST" ]; then
      tmux kill-window
    fi
  fi
}

rotateccw() {
  tmux rotate-window -U\; select-pane -t "$BASE_IDX"
}

rotatecw() {
  tmux rotate-window -D\; select-pane -t "$BASE_IDX"
}

focus() {
  tmux swap-pane -s :. -t "$BASE_IDX"\; select-pane -t "$BASE_IDX"
}
# # Edit values if you use custom resize_count variables
# tmux bind-key -n M-h if-shell "$is_vim" "send-keys M-h"  "resize-pane -L 10"
# tmux bind-key -n M-j if-shell "$is_vim" "send-keys M-j"  "resize-pane -D 5"
# tmux bind-key -n M-k if-shell "$is_vim" "send-keys M-k"  "resize-pane -U 5"
# tmux bind-key -n M-l if-shell "$is_vim" "send-keys M-l"  "resize-pane -R 10"
# 
# tmux bind-key -T copy-mode-vi M-h resize-pane -L 10
# tmux bind-key -T copy-mode-vi M-j resize-pane -D 5
# tmux bind-key -T copy-mode-vi M-k resize-pane -U 5
# tmux bind-key -T copy-mode-vi M-l resize-pane -R 10

layouttile() {
  tmux select-layout main-vertical\; resize-pane -t "$BASE_IDX" -x "${FACTOR:-50}"%
}

if [ $# -lt 1 ]; then
  echo "dwm.tmux.sh [command]"
  exit
fi

command=$1;shift

case $command in
  newpane) newpane;;
  killpane) killpane;;
  rotateccw) rotateccw;;
  rotatecw) rotatecw;;
  focus) focus;;
  layouttile) layouttile;;
  *) echo "unknown command"; exit 1;;
esac
