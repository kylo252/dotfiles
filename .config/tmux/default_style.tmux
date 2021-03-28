# Various colors.
set -g status-style fg=colour244
set -g window-status-current-style fg=colour222
set -g pane-border-style fg=colour240
set -g pane-active-border-style fg=colour243

set -g status-left ''
set -g status-left-length 0
set -g status-right ''
set -g status-right-length 0

# Display a clock on the bottom right of the status bar.
set -g status-right '%a %Y-%m-%d %H:%M'
set -g status-right-length 20

set-option -g status-position top

