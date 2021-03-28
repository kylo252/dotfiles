#!/usr/bin/env bash

set -eu

function __setup_defaults() {

  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"

  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  export EDITOR=nvim

  export ZDOTDIR="$HOME/.config/zsh"

}

function __setup_deps() {

  __setup_defaults

  [ -z "$XDG_DATA_HOME" ] && echo "environment init error" && return 1

  echo "Fetchings dependencies.."

  export DOTBARE_DIR="$HOME/.dtf.git"
  export DOTBARE_TREE="$HOME"

  if [ ! -d "$XDG_DATA_HOME/dotbare" ]; then
    git clone https://github.com/kazhala/dotbare.git "$XDG_DATA_HOME/dotbare"
  fi

  if [ ! -d "$HOME/.dtf.git" ]; then
    "$XDG_DATA_HOME/dotbare/dotbare" finit -u https://github.com/kylo252/dotfiles.git
  fi

  if [ ! -d "$XDG_DATA_HOME/zgenom" ]; then
    git clone https://github.com/jandamm/zgenom.git "$XDG_DATA_HOME/zgenom"
  fi

  echo 'Installing zsh plugins'

  zsh -c "source $ZDOTDIR/utils.zsh"

}

function __setup_utils() {

  echo "setting up fzf.."

  if [ ! -d "$XDG_DATA_HOME/fzf" ]; then
    git clone https://github.com/junegunn/fzf.git "$XDG_DATA_HOME/fzf"
  fi

  "$XDG_DATA_HOME/fzf/install" --all --xdg --completion --no-update-rc

  echo "settings up tmux.."

  local TPM_DIR=$XDG_CONFIG_HOME/tmux/plugins/tpm

  if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi
}

__setup_deps
__setup_utils
unset -f __setup_deps
unset -f __setup_utils

