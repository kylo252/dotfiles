#!/usr/bin/env bash

WINDOW_PANES="$(tmux display -p "#{window_panes}")"

newpane() {
  tmux \
    split-window -t "{left}" -c "#{pane_current_path}" \; \
    swap-pane -t "{previous}" -d\; \
    select-layout main-vertical\; \
    resize-pane -t "{left}" -x "${FACTOR:-50}"%
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
  tmux rotate-window -U\; select-pane -t "{left}"
}

rotatecw() {
  tmux rotate-window -D\; select-pane -t "{left}"
}

focus() {
  tmux swap-pane -s :. -t "{left}"\; select-pane -t "{left}"
}

layouttile() {
  tmux select-layout main-vertical\; resize-pane -t "{left}" -x "${FACTOR:-50}"%
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
