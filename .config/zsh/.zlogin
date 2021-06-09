#!/usr/bin/env zsh
  
# shellcheck disable
# Asynchronously zcompile .zcompdump file.
{
  typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"

  if ([[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]) {
    zcompile "$zcompdump"
  }
} &!
# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session

if [ -n "${DISPLAY}" ] &&  command -v smug >/dev/null; then
  [ -z "${TMUX}" ] && { tmux attach -t default || smug start default -a; } >/dev/null 2>&1
fi
