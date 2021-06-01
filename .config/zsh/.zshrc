#!/usr/bin/env zsh

# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# There's a problem with starting instant-prompt and creating a new tmux session
if [ -z "$VIRTUAL_ENV" ] && [ -n "$TMUX" ]; then
  if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

source "$XDG_CONFIG_HOME/zsh/.p10k.lean.zsh"

_bin_list=(
  "$HOME/.local/bin"
  "$HOME/local/bin"
  "$HOME/bin"
  "$CARGO_HOME/bin"
  "$GEM_HOME/bin"
  "$NPM_HOME/bin"
  "$GOPATH/bin"
  )

for extra in "${_bin_list[@]}"; do
  PATH=$extra:$PATH
done
export PATH
unset _bin_list

# just in case latest zsh is not in '/usr/bin'
# it's probably unnecessary
SHELL="$(command -v zsh)"
export SHELL

function __setup_x11() {
  if apt-get -v &> /dev/null; then
    return 
  fi
  if [ -z "$SSH_CONNECTION" ]; then
    # How to check if WSL1/2
    # https://github.com/microsoft/WSL/issues/4555#issuecomment-609908080
    if [ -d /run/WSL ]; then
      # How to set up working X11 forwarding on WSL2
      # https://stackoverflow.com/a/61110604
      # DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
      DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
	  source "$ZDOTDIR/utils/ssh-agent.zsh"
    else
      DISPLAY=localhost:0
    fi
    export DISPLAY
    export LIBGL_ALWAYS_INDIRECT=1
  fi
}

__setup_x11

source "$ZDOTDIR/opts.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/functions.zsh"

source "$ZDOTDIR/plugins.zsh"

if [ -d "$XDG_CONFIG_HOME/rhel" ] && [ -z "$MANPATH_og" ] ; then
  source "$XDG_CONFIG_HOME/rhel/settings.sh"
fi

# zprof
