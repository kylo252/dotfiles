#!/usr/bin/env zsh


function __setup_history() {
    setopt EXTENDED_HISTORY        # Write the history file in the ":start:elapsed;command" format.
    setopt HIST_FCNTL_LOCK         # Use  system’s fcntl call where available (better performance)
    setopt HIST_FIND_NO_DUPS       # don't show dupes when searching
    setopt HIST_IGNORE_DUPS        # do filter contiguous duplicates from history
    setopt HIST_IGNORE_SPACE       # Do not record an entry starting with a space.
    setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks before recording entry.
    setopt HIST_VERIFY             # Do not execute immediately upon history expansion.
    setopt INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY           # Share history between all sessions.
}
__setup_history; unset -f __setup_history

function __setup_defaults() {
    setopt NO_BEEP                 # disable the goddamn beep!
    setopt CORRECT                 # Command auto-correction
    setopt CORRECT_ALL             # Argument auto-correction
    setopt IGNORE_EOF              # Prevent accidental C-d from exiting shell
    setopt INTERACTIVE_COMMENTS    # Allow comments, even in interactive shells
    setopt LIST_PACKED             # Make completion lists more densely packed
}
__setup_defaults; unset -f __setup_defaults

function __setup_kemaps() {

    bindkey -e

    # Fix backspace not working after returning from cmd mode
    bindkey '^?' backward-delete-char
    bindkey '^h' backward-delete-char 

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

    bindkey '^[[1;5C' vi-forward-word

    # [muscle-memory] use alt+. to repeat argument
    bindkey '\e.' insert-last-word
}
__setup_kemaps; unset -f __setup_kemaps

