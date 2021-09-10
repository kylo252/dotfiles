#!/usr/bin/env zsh
  
# Asynchronously zcompile .zcompdump file.
{
  typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"

  if ([[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]) {
    zcompile "$zcompdump"
  }
} &!
# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session

# if [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#    command -v smug >/dev/null && { tmux attach -t default || smug start default -a; } >/dev/null 2>&1
# fi

# Use of stty should really only be used with interactive shells.
if [[ -o interactive ]]; then
# https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator
# stty stop ''
  stty -ixon
fi
