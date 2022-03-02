#!/usr/bin/env bash

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"

if [ -d "$XDG_CONFIG_HOME/rhel" ]; then
  source "$XDG_CONFIG_HOME/rhel/settings.sh"
fi

source "$XDG_CONFIG_HOME/bash/exports.bash"

source "$XDG_CONFIG_HOME/bash/aliases.bash"

if [ -n "$DISPLAY" ]; then
  # append to the history file, don't overwrite it
  shopt -s histappend

  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
  fi

  [ -e "$XDG_CONFIG_HOME/fzf/fzf.bash" ] && source "$XDG_CONFIG_HOME/fzf/fzf.bash"
  eval "$(starship init bash)"
fi
