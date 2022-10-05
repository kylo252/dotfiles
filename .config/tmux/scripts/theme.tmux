#!/usr/bin/env bash

## onedark
black="#282c34"
white="#aab2bf"
blue="#61afef"
yellow="#e5c07b"
red="#e06c75"
green="#98c379"
dark_grey="#3e4452"

time_format="%R"
extra_widget=" "
date_format="%d/%m/%y"

if [ -n "$SSH_CONNECTION" ]; then
  host_format="#h"
else
  host_format="local"
fi

tmux set -g status "on"

# bg=default will set the color automatically as the terminal
tmux set -g status-style bg=default,none
tmux set -g status-justify "left"

tmux set -g status-right-style none
tmux set -g status-left-style none

tmux set -g status-left-length "100"
tmux set -g status-right-length "100"

tmux set -g message-style fg="$white"
tmux set -g message-command-style fg="$white"

tmux set -g window-style fg="$dark_grey"
tmux set -g window-active-style fg="$white"

tmux set -g pane-border-style fg="$white"
tmux set -g pane-active-border-style fg="$green"

tmux set -g display-panes-active-colour "$yellow"
tmux set -g display-panes-colour "$blue"

tmux setw -g window-status-style none
tmux setw -g window-status-activity-style none

tmux setw -g window-status-separator ""

tmux set -g "@prefix_highlight_fg" "$black"
tmux set -g "@prefix_highlight_bg" "$green"
tmux set -g "@prefix_highlight_copy_mode_attr" "fg=$black,bg=$green"
tmux set -g "@prefix_highlight_output_prefix" "  "

# checking `#{pane_current_command}` does not work when neovim is invoked from another program, e.g. `lf`.
current_cmd="#(ps -o command= -t '#{pane_tty}' | rg -o '^(n?l?vim)' || echo '#{pane_current_command}')"
# pgrep wasn't that useful here since the output format doesn't seem configurable
# current_cmd="#(pgrep -t '#{pane_tty}' -la '^(nvim|lvim|vim)' | grep -oP '\d+ \K(n?l?vim)' || echo '#{pane_current_command}')"

# automatically rename windows to the current directory
current_path='#{b:pane_current_path}'

# TODO: consider adding a git-status "#(gitmux '#{pane_current_path}')"
status_right=(
  "#[fg=$white,bg=default,nounderscore,noitalics]${extra_widget}"
  ""
  "${date_format}"
  "#[fg=$dark_grey,bg=default]#[fg=$white, bg=$dark_grey]"
  "${time_format}"
  "#[fg=$green,bg=$dark_grey,nobold,nounderscore,noitalics]#[fg=$black,bg=$green,bold]"
  "$host_format"
  "#[fg=$yellow, bg=$green]#[fg=$red,bg=$yellow]"
)

status_left=(
  "#[fg=$black,bg=$green,bold] #S"
  "#{prefix_highlight}#[fg=$green,bg=default,nobold,nounderscore,noitalics]"
)

current_win_status_format=(
  "#[fg=$black,bg=$dark_grey,nobold,nounderscore,noitalics]#[fg=$white,bg=$dark_grey,nobold]"
  "#I"
  ""
  "#[fg=$green]$current_cmd"
  "#[fg=$blue]$current_path"
  "#[fg=$dark_grey,bg=default,nobold,nounderscore,noitalics]"
)

win_status_format=(
  "#[fg=$black,bg=default,nobold,nounderscore,noitalics]#[fg=$white,bg=default]"
  "#I"
  ""
  "#[fg=$green]$current_cmd"
  "#[fg=$dark_grey]$current_path"
  "#[fg=$black,bg=default,nobold,nounderscore,noitalics]"
)

tmux set -g status-right "${status_right[*]}"
tmux set -g status-left "${status_left[*]}"

tmux setw -g window-status-current-format "${current_win_status_format[*]}"
tmux setw -g window-status-format "${win_status_format[*]}"
