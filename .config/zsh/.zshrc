#!/usr/bin/env zsh

if [ -r /etc/redhat-release ]; then
    source "$HOME/.config/rhel/settings.sh"
else
    source "$ZDOTDIR/.zshrc.user"
fi
