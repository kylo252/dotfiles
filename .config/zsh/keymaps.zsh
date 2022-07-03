#!/usr/bin/env zsh

bindkey -e

# Fix backspace not working after returning from cmd mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# Edit line in vim buffer alt-v
autoload edit-command-line
zle -N edit-command-line
bindkey '^[v' edit-command-line

# Fix Home/End
# it seems to read differently in tmux for some reason
if [ -z "$TMUX" ]; then
  bindkey '^[[H' beginning-of-line
  bindkey '^[[F' end-of-line
else
  bindkey '^[OH' beginning-of-line
  bindkey '^[OF' end-of-line
fi

# Fix Delete
bindkey '^[[3~' delete-char

# [muscle-memory] kill line-forward
bindkey '^K' kill-line
bindkey '^X^K' kill-line

bindkey '^D' kill-word
bindkey '^H' backward-kill-word

# [muscle-memory] use alt+. to repeat argument
bindkey '^[.' insert-last-word

# repeat last written word before cursor
bindkey "^[," copy-prev-shell-word

# partial history search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# line suggestion
bindkey '^X^ ' autosuggest-accept

# workaround: partial accept suggestion
bindkey '^ ' vi-forward-word

bindkey '^[[1;5C' vi-forward-word # ctrl+right
bindkey '^[[1;5D' vi-backword-word # ctrl+left
