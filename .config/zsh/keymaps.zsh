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
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

function _expand_alias_wrapper(){
  zle _expand_alias
  # fix color as well as allow typing
  zle magic-space
}

zle -N _expand_alias_wrapper

bindkey '^Xa' _expand_alias_wrapper

bindkey '^@' vi-forward-word
bindkey '^X^@' vi-add-eol
bindkey '^[[1;5C' vi-forward-word # ctrl+right
bindkey '^[[1;5D' vi-backward-word # ctrl+left
