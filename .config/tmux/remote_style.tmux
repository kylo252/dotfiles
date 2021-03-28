# -------------------------------------------------------------------
# Decoration (256-color)
# -------------------------------------------------------------------
set-option -g status-justify left
set-option -g status-left '#[bg=colour72] #[bg=colour237] #[bg=colour236] #[bg=colour235]#[fg=colour185] #h #[bg=colour236] '
set-option -g status-left-length 16
set-option -g status-bg colour237
set-option -g status-right '#{?pane_synchronized, #[fg=colour196]*SYNC*#[default],}#[bg=colour236] #[bg=colour235]#[fg=colour185] #(date "+%a %b %d %H:%M") #[bg=colour236] #[bg=colour237] #[bg=colour72] '
set-option -g status-interval 60

set-option -g status-position top
set-option -g pane-border-status bottom
set-option -g pane-border-format "#{pane_index} #{pane_current_command}"
set-option -g pane-active-border-style fg=colour245
set-option -g pane-border-style fg=colour243

set-window-option -g window-status-format '#[bg=colour238]#[fg=colour107] #I #[bg=colour239]#[fg=colour110] #[bg=colour240]#W#[bg=colour239]#[fg=colour195]#F#[bg=colour238] '
set-window-option -g window-status-current-format '#[bg=colour236]#[fg=colour215] #I #[bg=colour235]#[fg=colour167] #[bg=colour234]#W#[bg=colour235]#[fg=colour195]#F#[bg=colour236] '

# set-window-option -g window-style 'bg=colour238'
# set-window-option -g window-active-style 'bg=colour237'

