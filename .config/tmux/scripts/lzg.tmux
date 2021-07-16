#!/usr/bin/env zsh

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
split_direction="$(get_option "@extrakto_split_direction")"
exec_cmd="$(get_option "@lazygit_exec_cmd")"
split_direction="$(get_option "@lazygit_split_direction")"

# TODO: fix split option
if [ -n "$split_direction" ]; then
  split_size="$(get_option "@lazygit_split_size")"
  tmux split-window \
    -"${split_direction}:-"R"" \
    -l "${split_size}:-"50%"" "tmux setw remain-on-exit off ${exec_cmd:-"lazygit"}"
else
  IFS=, read popup_width popup_height <<< "$(get_option "@lazygit_popup_size")"
  IFS=, read popup_x popup_y <<< "$(get_option "@lazygit_popup_position")"
  rc=129
  while [ $rc -eq 129 ]; do
    tmux popup \
      -d "#{pane_current_path}" \
      -w "${popup_width:-"80%"}" \
      -h "${popup_height:-"80%"}" \
      -x "${popup_x:-"C"}" \
      -y "${popup_y:-"C"}" \
      -E "${exec_cmd:-"lazygit"}"
      rc=$?
  done
  exit $rc
fi
