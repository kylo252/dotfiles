#!/usr/bin/env zsh

if [ -r /etc/redhat-release ]; then
    source "$ZDOTDIR/.zshrc.arc"
    source "$XDG_CONFIG_HOME/rhel/project_bashrc"
else
    source "$ZDOTDIR/.zshrc.user"
fi
