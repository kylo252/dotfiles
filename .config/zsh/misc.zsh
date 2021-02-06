#!/usr/bin/env zsh
#
# fix for 'module unload' for default modules
if [ -r /etc/redhat-release ]; then
  if [ -n "$TERM_PROGRAM" ] && [ -z "$TMUX" ]; then
    _prep_vscode_env
  else
    module restore minimal # rsw_updated
  fi 
fi

# fix for snaps
if [  -n "$(uname -a | grep Ubuntu)" ]; then
    emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'
fi
