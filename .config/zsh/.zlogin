#!/usr/bin/env zsh

# Auto-attach tmux.
if ( \
  (( $+commands[tmux] )) \
  && ([[ $TMUX == '' ]] && [[ $SUDO_USER == '' ]])
) {
  tmux attach-session -t 'default' 2>/dev/null && exit 0
  tmux new-session -s 'default' && exit 0
}

# Asynchronously zcompile .zcompdump file.
{
  typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"

  if ([[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]) {
    zcompile "$zcompdump"
  }
} &!
