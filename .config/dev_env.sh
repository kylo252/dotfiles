#!/usr/bin/env bash

# Fix module path taken from /app/arc/2.4/profiles/arc.bashrc
#unset MODULEPATH
#export MODULEPATH=$MODULEPATH_TCSH

PATH=~/bin:$PATH
PATH=~/local/bin:$PATH
PATH=~/.local/bin:$PATH 
export PATH

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"

[ -z "$HISTFILE" ] && export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"

[ -z "$ZDOTDIR" ] && export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

[ -z "$BASHDOTDIR" ] && export BASHDOTDIR="$XDG_CONFIG_HOME/bash"

[ -z "$NPM_CONFIG_USERCONFIG" ] && export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

[ -z "$RIPGREP_CONFIG_PATH" ] && export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

[ -z "$GEM_HOME" ] && export GEM_HOME="$XDG_DATA_HOME/gem"

[ -z "$GEM_SPEC_CACHE" ] && export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export NVM_DIR="$XDG_CONFIG_HOME/nvm"

export HISTTIMEFORMAT="%h %d %H:%M:%S "
export HISTSIZE=100000
export HISTFILESIZE=2000000
export HISTFILE="$XDG_DATA_HOME/shell/history"
shopt -s histappend
export HISTIGNORE="ls:ps:history"
PROMPT_COMMAND='history -a'
