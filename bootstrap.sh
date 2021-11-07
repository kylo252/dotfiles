#!/usr/bin/env bash
set -eou pipefail

function check_reqs() {
  local reqs=(
    git
    zsh
    nvim
  )
  for req in "${reqs[@]}"; do
    if ! command -v "$req"; then
      echo ">>> ERROR: missing requirement: $req"
      echo ">>> please install and re-run the script again" && exit 1
    fi
  done
}

function setup_default_exports() {

  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"

  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  export EDITOR=nvim

  export ZDOTDIR="$HOME/.config/zsh"

  export DOTBARE_DIR="$HOME/.dtf.git"
  export DOTBARE_TREE="$HOME"
  export DOTBARE_INSTALL_PREFIX="$XDG_DATA_HOME/zsh/plugins/dotbare"

  export TPM_DIR="$XDG_DATA_HOME/tmux/plugins/tpm"
}

function setup_dotfiles() {

  check_reqs
  setup_default_exports

  echo "Fetching dependencies.."

  if [ ! -d "$DOTBARE_INSTALL_PREFIX" ]; then
    git clone --depth=1 https://github.com/kazhala/dotbare "$DOTBARE_INSTALL_PREFIX"
  fi

  if [ ! -d "$HOME/.dtf.git" ]; then
    "$DOTBARE_INSTALL_PREFIX/dotbare" finit -u https://github.com/kylo252/dotfiles.git
    ln -sf "$XDG_CONFIG_HOME/git/hooks/dots_post_commit" "$DOTBARE_DIR/hooks/pre-push"
    chmod +x "$DOTBARE_DIR/hooks/pre-push"
  fi

  local znap_dir="$XDG_DATA_HOME/zsh/plugins/znap"
  if [ ! -d "$znap_dir" ]; then
    echo 'setting up zsh ...'
    git clone --depth=1 https://github.com/marlonrichert/zsh-snap "$znap_dir"
    zsh -c "source $ZDOTDIR/plugins.zsh"
  fi

  if [ ! -d "$XDG_DATA_HOME/fzf" ]; then
    git clone --depth=1 https://github.com/junegunn/fzf "$XDG_DATA_HOME/fzf"
  fi

  echo "setting up fzf .."
  "$XDG_DATA_HOME/fzf/install" --all --xdg --completion --no-update-rc

  echo "setting up tmux.."
  if [ ! -d "$TPM_DIR" ]; then
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
  fi
  echo "setup complete!"
}

setup_dotfiles

unset -f check_reqs
unset -f setup_dotfiles
unset -f setup_default_exports
