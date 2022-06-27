#!/usr/bin/env bash
set -e

BASE_IDX=${BASE_IDX:-"$(tmux display -p "#{pane-base-index}")"}

function main() {
  if [ $# -lt 1 ]; then
    echo "dwm.tmux.sh [command]"
    exit
  fi

  command=$1
  shift

  case $command in
    newpane) newpane ;;
    rotateccw) rotateccw ;;
    rotatecw) rotatecw ;;
    focus) focus ;;
    layouttile) layouttile ;;
    zoom) zoom ;;
    float) float ;;
    togglepane) togglepane ;;
    *)
      echo "unknown command"
      exit 1
      ;;
  esac
}

window_panes="$(tmux display -p "#{window_panes}")"

function newpane() {
  tmux split-window -v -c '#{pane_current_path}' -l 30
}

function togglepane() {
  if ((window_panes > 1)); then
    tmux resize-pane -t "$BASE_IDX" -Z
  else
    tmux split-window -v -c '#{pane_current_path}' -l 30
  fi
}

function rotateccw() {
  tmux rotate-window -U\; select-pane -t "$BASE_IDX"
}

function rotatecw() {
  tmux rotate-window -D\; select-pane -t "$BASE_IDX"
}

function focus() {
  tmux swap-pane -s :. -t "$BASE_IDX"\; select-pane -t "$BASE_IDX"
}

function layouttile() {
  tmux select-layout main-horizontal\; resize-pane -t "$BASE_IDX" -y "${FACTOR:-70}"%
}

function float() {
  tmux resize-pane -Z
}

main "$@"
