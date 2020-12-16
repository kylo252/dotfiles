#!/usr/bin/env zsh

# Fix module path taken from /app/arc/2.4/profiles/arc.bashrc
#unset MODULEPATH
#export MODULEPATH=$MODULEPATH_TCSH

PATH=~/local/bin:$PATH
PATH=~/.local/bin:$PATH 
PATH=~/.scripts:$PATH
export PATH

export XDG_CONFIG_HOME="$HOME/.config"

export XDG_DATA_HOME="$HOME/.local/share"

export XDG_CACHE_HOME="$HOME/.cache"

export HISTFILE="$XDG_DATA_HOME/shell/history"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"

export GEM_HOME="$XDG_DATA_HOME/gem"

export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

export GOPATH="$XDG_DATA_HOME/go"

export NVM_DIR="$XDG_DATA_HOME/nvm"

export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"

