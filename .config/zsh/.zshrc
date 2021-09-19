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
      # DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
      DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0
      PULSE_SERVER=tcp:$(echo /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
	  source "$ZDOTDIR/utils/ssh-agent.zsh"
    else
      DISPLAY=localhost:0
    fi
    export DISPLAY
    export LIBGL_ALWAYS_INDIRECT=1
  fi
}

__setup_x11


source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/functions.zsh"

source "$ZDOTDIR/completions.zsh"

source "$ZDOTDIR/opts.zsh"

source "$ZDOTDIR/plugins.zsh"

if [ -d "$XDG_CONFIG_HOME/rhel" ] && [ -z "$MANPATH_og" ] ; then
  source "$XDG_CONFIG_HOME/rhel/settings.sh"
fi

# zprof
