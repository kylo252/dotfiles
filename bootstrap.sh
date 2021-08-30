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
      echo ">>> please install and re-run the script again" && exit 1
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

  export TPM_DIR="$XDG_DATA_HOME/tmux/plugins/tpm"
}

function __setup_dotfiles() {

  __check_reqs
  __setup_default_exports

  echo "Fetching dependencies.."

  if [ ! -d "$XDG_DATA_HOME/dotbare" ]; then
    git clone https://github.com/kazhala/dotbare "$XDG_DATA_HOME/dotbare"
  fi

  if [ ! -d "$HOME/.dtf.git" ]; then
    "$XDG_DATA_HOME/dotbare/dotbare" finit -u https://github.com/kylo252/dotfiles.git
    ln -sf "$XDG_CONFIG_HOME/git/hooks/dots_post_commit" "$HOME/.dtf.git/hooks/pre-push"
    chmod +x "$HOME/.dtf.git/hooks/pre-push"
  fi

  echo 'Installing zsh plugins'

  local ZNAP_DIR="$XDG_DATA_HOME/zsh/plugins/znap"
  if [ ! -d "$ZNAP_DIR" ]; then
    git clone https://github.com/marlonrichert/zsh-snap "$ZNAP_DIR"
  fi

  zsh -c "source $ZDOTDIR/plugins.zsh"

  echo "setting up fzf.."

  if [ ! -d "$XDG_DATA_HOME/fzf" ]; then
    git clone https://github.com/junegunn/fzf "$XDG_DATA_HOME/fzf"
  fi

  "$XDG_DATA_HOME/fzf/install" --all --xdg --completion --no-update-rc

  echo "setting up tmux.."

  if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi
}

__setup_dotfiles

unset -f __check_reqs
unset -f __setup_dotfiles
unset -f __setup_default_exports
