#!/usr/bin/env zsh

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
split_direction="$(get_option "@extrakto_split_direction")"
exec_cmd="$(get_option "@lf_exec_cmd")"
split_direction="$(get_option "@lf_split_direction")"

# TODO: fix split option
if [ -n "$split_direction" ]; then
  split_size="$(get_option "@lf_split_size")"
  tmux split-window \
    -"${split_direction}:-"R"" \
    -l "${split_size}:-"50%"" "tmux setw remain-on-exit off ${exec_cmd:-"lf"}"
else
  IFS=, read popup_width popup_height <<< "$(get_option "@lf_popup_size")"
  IFS=, read popup_x popup_y <<< "$(get_option "@lf_popup_position")"
  tmux popup \
      -d "#{pane_current_path}" \
      -w "${popup_width:-"80%"}" \
      -h "${popup_height:-"50%"}" \
      -x "${popup_x:-"C"}" \
      -y "${popup_y:-"C"}" \
      -E "${exec_cmd:-"lf -single"}"
  exit 0
fi
