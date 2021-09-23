#!/usr/bin/env bash
set -ex

function toggle_lf() {
  split_direction="$1"
  split_size="$2"

  if [ -n "$split_direction" ]; then
    tmux split-window \
      -"$split_direction" \
      -l "${split_size:-"50%"}" "${lf_exec_cmd:-"lf"}"
  else
    tmux popup \
      -d "#{pane_current_path}" \
      -w "${tmux_popup_width:-"80%"}" \
      -h "${tmux_popup_height:-"80%"}" \
      -x "${tmux_popup_x:-"C"}" \
      -y "${tmux_popup_y:-"C"}" \
      -E "${lf_exec_cmd:-"lf -single"}"
  fi
}

toggle_lf "$@"
