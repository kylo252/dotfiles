#!/usr/bin/env zsh

if [ -d "$HOME/.ssh/keys" ]; then
  eval "$(keychain --eval --quiet ~/.ssh/keys/*_rsa)"
fi

