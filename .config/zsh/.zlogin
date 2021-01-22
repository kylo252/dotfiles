#!/usr/bin/env zsh

# testing to run from here instead of .zprofile
# since it seems to keep getting over-writtern
login::setup_history() {
    setopt EXTENDED_HISTORY              # Write the history file in the ":start:elapsed;command" format.
    setopt INC_APPEND_HISTORY            # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY                 # Share history between all sessions.
    setopt HIST_IGNORE_SPACE             # Do not record an entry starting with a space.
    setopt HIST_REDUCE_BLANKS            # Remove superfluous blanks before recording entry.
    setopt HIST_VERIFY                   # Do not execute immediately upon history expansion.
    setopt HIST_BEEP                     # Beep when accessing nonexistent history.
}

login::setup_history; unset -f login::setup_history

bindkey -e

# Fix backspace not working after returning from cmd mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char 

# Re-enable incremental search from emacs mode (it's useful)
bindkey '^r' history-incremental-search-backward

# Edit line in vim buffer ctrl-v
# autoload edit-command-line; zle -N edit-command-line
# bindkey '^v' edit-command-line

# Enter vim buffer from normal mode
# autoload -U edit-command-line && zle -N edit-command-line && bindkey -M vicmd "^v" edit-command-line

# Fix Home/End
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# Fix Delete
bindkey '^[[3~' delete-char

# [muscle-memory] kill line-forward
bindkey '^K' kill-line

# [muscle-memory] use ctrl+backspace as well
bindkey '^H' backward-kill-word

# https://stackoverflow.com/a/1438523
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# [muscle-memory] use alt+. to repeat argument
bindkey '\e.' insert-last-word

# disable the goddamn beep!
unsetopt BEEP

