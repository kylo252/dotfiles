#!/usr/bin/env bash

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"

if [ -d "$XDG_CONFIG_HOME/rhel" ]; then
  source "$XDG_CONFIG_HOME/rhel/project_bashrc"
  source "$XDG_CONFIG_HOME/rhel/project_env"
fi

source "$XDG_CONFIG_HOME/bash/.bash_exports"

source "$XDG_CONFIG_HOME/bash/.bash_aliases"

# this for now managed by bash-it
# source "$XDG_CONFIG_HOME/bash/.bash_prompt"

# bash-it config
if [ "$TERM_PROGRAM" != "vscode" ]; then
  source "$XDG_CONFIG_HOME/bash/settings.bash"
fi
