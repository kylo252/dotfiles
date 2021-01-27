#!/usr/bin/env zsh

if [ -r /etc/redhat-release ]; then
    source "$ZDOTDIR/.zshrc.arc"
    source "$XDG_CONFIG_HOME/rhel/project_bashrc"
    # temporary attempt
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
else
    source "$ZDOTDIR/.zshrc.user"
fi
