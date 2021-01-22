#!/usr/bin/env zsh

# zmodload zsh/zprof
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [ -z "$VIRTUAL_ENV" ]; then
   if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
     source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
   fi
fi

# we should fix the path here instead of .zprofile
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/local/bin:$PATH
export PATH 

source "$ZDOTDIR/.zsh_aliases"

source "$ZDOTDIR/.zsh_functions"

source "$ZDOTDIR/.zsh_plugins"

source "$ZDOTDIR/.zsh_prompt"

source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

# fix for 'module unload' for default modules
if [ -r /etc/redhat-release ]; then
  if [ -n "$TERM_PROGRAM" ]; then
    _prep_vscode_env
  else
    module restore minimal # rsw_updated
  fi 
fi

# testing to run from here instead of .zprofile
# since it seems to keep getting over-writtern
setup_history() {
    export HISTFILE="$XDG_DATA_HOME/shell/history"
    export HISTSIZE=100000               # History size in memory
    export SAVEHIST=1000000              # The number of histsize
    export LISTMAX=50                    # The size of asking history
    setopt EXTENDED_HISTORY              # Write the history file in the ":start:elapsed;command" format.
    setopt INC_APPEND_HISTORY            # Write to the history file immediately, not when the shell exits.
    setopt SHARE_HISTORY                 # Share history between all sessions.
    setopt HIST_IGNORE_SPACE             # Do not record an entry starting with a space.
    setopt HIST_REDUCE_BLANKS            # Remove superfluous blanks before recording entry.
    setopt HIST_VERIFY                   # Do not execute immediately upon history expansion.
    setopt HIST_BEEP                     # Beep when accessing nonexistent history.
    # Do not add in root
    [[ "$UID" == 0 ]] && unset HISTFILE && SAVEHIST=0
}
setup_history; unset -f setup_history

# zprof
