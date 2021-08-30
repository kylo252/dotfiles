#!/usr/bin/env bash

IS_VIM="tmux display -p '#{pane_current_command}' | rg 'nvim'"

bind -n 'C-h' if-shell "$IS_VIM" 'send-keys C-h' { if -F '#{pane_at_left}' '' 'select-pane -L' }
bind -n 'C-j' if-shell "$IS_VIM" 'send-keys C-j' { if -F '#{pane_at_bottom}' '' 'select-pane -D' }
bind -n 'C-k' if-shell "$IS_VIM" 'send-keys C-k' { if -F '#{pane_at_top}' '' 'select-pane -U' }
bind -n 'C-l' if-shell "$IS_VIM" 'send-keys C-l' { if -F '#{pane_at_right}' '' 'select-pane -R' }

bind -T copy-mode-vi 'C-h' if -F '#{pane_at_left}' '' 'select-pane -L'
bind -T copy-mode-vi 'C-j' if -F '#{pane_at_bottom}' '' 'select-pane -D'
bind -T copy-mode-vi 'C-k' if -F '#{pane_at_top}' '' 'select-pane -U'
bind -T copy-mode-vi 'C-l' if -F '#{pane_at_right}' '' 'select-pane -R'

bind -n 'M-h' if-shell "$IS_VIM" 'send-keys M-h' 'resize-pane -L 1'
bind -n 'M-j' if-shell "$IS_VIM" 'send-keys M-j' 'resize-pane -D 1'
bind -n 'M-k' if-shell "$IS_VIM" 'send-keys M-k' 'resize-pane -U 1'
bind -n 'M-l' if-shell "$IS_VIM" 'send-keys M-l' 'resize-pane -R 1'

bind -T copy-mode-vi M-h resize-pane -L 1
bind -T copy-mode-vi M-j resize-pane -D 1
bind -T copy-mode-vi M-k resize-pane -U 1
bind -T copy-mode-vi M-l resize-pane -R 1