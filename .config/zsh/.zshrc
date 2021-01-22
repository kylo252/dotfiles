#!/usr/bin/env zsh

if [ -r /etc/redhat-release ]; then
    source "$ZDOTDIR/.zshrc.arc"
else
    source "$ZDOTDIR/.zshrc.user"
fi
