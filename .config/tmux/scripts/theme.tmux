#!/bin/sh

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

tmux set-option -gq "status-right" "#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]${extra_widget}  ${date_format} #[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey]#[fg=$onedark_white, bg=$onedark_visual_grey]${time_format} #[fg=$onedark_green,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_green,bold] $host_format #[fg=$onedark_yellow, bg=$onedark_green]#[fg=$onedark_red,bg=$onedark_yellow]"
tmux set-option -gq "status-left" "#[fg=$onedark_black,bg=$onedark_green,bold] #S #{prefix_highlight}#[fg=$onedark_green,bg=$onedark_black,nobold,nounderscore,noitalics]"

tmux set-option -gq "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black] #I  #W #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
tmux set-option -gq "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_visual_grey,nobold] #I  #W #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
