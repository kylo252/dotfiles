#!/usr/bin/env zsh

# Auto-attach tmux.
# function _start_tmux_session() {
#  if command -v smug >/dev/null; then
#    smug start $1
#  else
#    tmux new-session -s $1
#  fi
# }
#   
# 
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
# 	if ! command -v lsb_release -a | rg 'RedHat' >/dev/null; then
# 		tmux attach-session -t 'default' 2>/dev/null && exit 0
# 		_start_tmux_session default
# 	fi
# fi

# unset -f _start_tmux_session


# shellcheck disable
# Asynchronously zcompile .zcompdump file.
{
  typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"

  if ([[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]) {
    zcompile "$zcompdump"
  }
} &!
