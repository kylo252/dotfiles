#!/usr/bin/env bash

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"

if [ -d "$XDG_CONFIG_HOME/rhel" ]; then
  source "$XDG_CONFIG_HOME/rhel/settings.bash"
fi

source "$XDG_CONFIG_HOME/bash/exports.bash"

source "$XDG_CONFIG_HOME/bash/aliases.bash"

source "$XDG_CONFIG_HOME/bash/settings.bash"
