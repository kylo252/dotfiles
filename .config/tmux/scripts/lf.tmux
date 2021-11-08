#!/usr/bin/env bash
set -e

function toggle_lf() {
  path="$1"
  split_direction="$2"
  split_size="$3"

  if [ -n "$split_direction" ]; then
    tmux split-window \
      -c '#{pane_current_path}' \
      -"$split_direction" \
      -l "${split_size:-"30%"}" "${lf_exec_cmd:-"lf -config $XDG_CONFIG_HOME/lf/lfrc.compact"} $path"
  else
    tmux popup \
      -d '#{pane_current_path}' \
      -w "${tmux_popup_width:-"80%"}" \
      -h "${tmux_popup_height:-"80%"}" \
      -x "${tmux_popup_x:-"C"}" \
      -y "${tmux_popup_y:-"C"}" \
      -E "${lf_exec_cmd:-"lf -single"}"
  fi
}

toggle_lf "$@"
