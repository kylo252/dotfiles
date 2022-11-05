#!/usr/bin/env zsh
  
# Asynchronously zcompile .zcompdump file.
{
  typeset -g zcompdump="$XDG_CACHE_HOME/zsh/compdump"

  if ([[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]) {
    zcompile "$zcompdump"
  }
} &!

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  export GDK_BACKEND=wayland
  export MOZ_ENABLE_WAYLAND=1
  # if [[ ! "$XDG_DATA_DIRS" =~ "$XDG_DATA_HOME" ]]; then
  #   export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_DIRS"
  # fi
fi

# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session

# if [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#    command -v smug >/dev/null && { tmux attach -t default || smug start default -a; } >/dev/null 2>&1
# fi

# # Use of stty should really only be used with interactive shells.
# if [[ -o interactive ]]; then
# # https://unix.stackexchange.com/questions/72086/ctrl-s-hangs-the-terminal-emulator
# # stty stop ''
#   stty -ixon
# fi
