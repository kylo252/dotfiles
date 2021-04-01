#!/usr/bin/env bash

set -eu

function __check_reqs() {
  __reqs=(
    git
    zsh
    nvim
  )

  for req in "${__reqs[@]}"; do
    if ! command -v "$req"; then
      echo ">>> ERROR: missing requirement: $req"
      echo ">>> please install and re-run the script again"
    fi
  done
  unset __reqs
}

function __setup_default_exports() {

  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"

  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  export EDITOR=nvim

  export ZDOTDIR="$HOME/.config/zsh"

  export DOTBARE_DIR="$HOME/.dtf.git"

  export DOTBARE_TREE="$HOME"
}

function __setup_deps() {

  __setup_default_exports

  echo "Fetchings dependencies.."

  if [ ! -d "$XDG_DATA_HOME/dotbare" ]; then
    git clone https://github.com/kazhala/dotbare "$XDG_DATA_HOME/dotbare"
  fi

  if [ ! -d "$HOME/.dtf.git" ]; then
    "$XDG_DATA_HOME/dotbare/dotbare" finit -u https://github.com/kylo252/dotfiles.git
  fi

  if [ ! -d "$XDG_DATA_HOME/zgenom" ]; then
    git clone https://github.com/jandamm/zgenom "$XDG_DATA_HOME/zgenom"
  fi

  echo 'Installing zsh plugins'

  zsh -c "source $ZDOTDIR/utils.zsh"

}

function __setup_utils() {

  echo "setting up fzf.."

  if [ ! -d "$XDG_DATA_HOME/fzf" ]; then
    git clone https://github.com/junegunn/fzf "$XDG_DATA_HOME/fzf"
  fi

  "$XDG_DATA_HOME/fzf/install" --all --xdg --completion --no-update-rc

  echo "setting up tmux.."

  local TPM_DIR=$XDG_CONFIG_HOME/tmux/plugins/tpm

  if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi
}

__check_reqs
__setup_deps
__setup_utils

unset -f __check_reqs
unset -f __setup_deps
unset -f __setup_utils
unset -f __setup_default_exports
