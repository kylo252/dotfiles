#!/usr/bin/env bash

onedark_black="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_visual_grey="#3e4452"
onedark_comment_grey="#5c6370"

time_format="%R"
extra_widget=" "
date_format="%d/%m/%y"

if [ -n "$SSH_CONNECTION" ]; then
  host_format="#h"
else
  host_format="local"
fi

tmux set-option -gq "status" "on"
tmux set-option -gq "status-justify" "left"

tmux set-option -gq "status-left-length" "100"
tmux set-option -gq "status-right-length" "100"
tmux set-option -gq "status-right-attr" "none"

tmux set-option -gq "message-fg" "$onedark_white"
tmux set-option -gq "message-bg" "$onedark_black"

tmux set-option -gq "message-command-fg" "$onedark_white"
tmux set-option -gq "message-command-bg" "$onedark_black"

tmux set-option -gq "status-attr" "none"
tmux set-option -gq "status-left-attr" "none"

tmux set-option -gq "window-style" "fg=$onedark_comment_grey"
tmux set-option -gq "window-active-style" "fg=$onedark_white"

tmux set-option -gq "pane-border-fg" "$onedark_white"
tmux set-option -gq "pane-border-bg" "$onedark_black"
tmux set-option -gq "pane-active-border-fg" "$onedark_green"
tmux set-option -gq "pane-active-border-bg" "$onedark_black"

tmux set-option -gq "display-panes-active-colour" "$onedark_yellow"
tmux set-option -gq "display-panes-colour" "$onedark_blue"

tmux set-option -gq "status-bg" "$onedark_black"
tmux set-option -gq "status-fg" "$onedark_white"

tmux set-window-option -gq "window-status-fg" "$onedark_black"
tmux set-window-option -gq "window-status-bg" "$onedark_black"
tmux set-window-option -gq "window-status-attr" "none"

tmux set-window-option -gq "window-status-activity-bg" "$onedark_black"
tmux set-window-option -gq "window-status-activity-fg" "$onedark_black"
tmux set-window-option -gq "window-status-activity-attr" "none"

tmux set-window-option -gq "window-status-separator" ""

tmux set-option -gq "@prefix_highlight_fg" "$onedark_black"
tmux set-option -gq "@prefix_highlight_bg" "$onedark_green"
tmux set-option -gq "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_green"
tmux set-option -gq "@prefix_highlight_output_prefix" "  "

# checking `#{pane_current_command}` does not work when neovim is invoked from another program, e.g. `lf`.
current_cmd="#(ps -f --no-headers -o command= -t '#{pane_tty}' | grep -oP '^(n?l?vim)' || echo '#{pane_current_command}')"
# pgrep wasn't that useful here since the output format doesn't seem configurable
# current_cmd="#(pgrep -t '#{pane_tty}' -la '^(nvim|lvim|vim)' | grep -oP '\d+ \K(n?l?vim)' || echo '#{pane_current_command}')"

# automatically rename windows to the current directory
current_path='#{b:pane_current_path}'

# TODO: consider adding a git-status "#(gitmux '#{pane_current_path}')"
status_right=(
  "#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]${extra_widget}"
  ""
  "${date_format}"
  "#[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey]#[fg=$onedark_white, bg=$onedark_visual_grey]"
  "${time_format}"
  "#[fg=$onedark_green,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_green,bold]"
  "$host_format"
  "#[fg=$onedark_yellow, bg=$onedark_green]#[fg=$onedark_red,bg=$onedark_yellow]"
)

status_left=(
  "#[fg=$onedark_black,bg=$onedark_green,bold] #S"
  "#{prefix_highlight}#[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"
)

current_win_status_format=(
  "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_visual_grey,nobold]"
  "#I"
  ""
  "#[fg=$onedark_green]$current_cmd"
  "#[fg=$onedark_blue]$current_path"
  "#[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
)

win_status_format=(
  "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black]"
  "#I"
  ""
  "#[fg=$onedark_green]$current_cmd"
  "#[fg=$onedark_visual_grey]$current_path"
  "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
)

tmux set-option -gq "status-right" "${status_right[*]}"
tmux set-option -gq "status-left" "${status_left[*]}"

tmux set-option -gq "window-status-current-format" "${current_win_status_format[*]}"
tmux set-option -gq "window-status-format" "${win_status_format[*]}"
