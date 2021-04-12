#!/usr/bin/env zsh

# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [ -z "$VIRTUAL_ENV" ]; then
  if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

if [ -n "$TMUX" ] || [ -n "$TERM_PROGRAM" ]; then
  source "$XDG_CONFIG_HOME/zsh/.p10k.lean.zsh"
# elif [ -n "$SSH_CONNECTION" ]; then
  # source "$XDG_CONFIG_HOME/zsh/.p10k.remote.zsh"
else
  source "$XDG_CONFIG_HOME/zsh/.p10k.default.zsh"
fi


__bin_list=(
  "$HOME/.local/bin"
  "$HOME/local/bin"
  "$HOME/bin"
  "$CARGO_HOME/bin"
  "$GEM_HOME/bin"
  "$GOPATH/bin"
  )

for extra in "${__bin_list[@]}"; do
  PATH=$extra:$PATH
done

export PATH
unset __bin_list

SHELL="$(command -v zsh)"
export SHELL

source "$ZDOTDIR/opts.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/functions.zsh"

source "$ZDOTDIR/plugins.zsh"

if [ -d "$XDG_CONFIG_HOME/rhel" ]; then
  source "$XDG_CONFIG_HOME/rhel/settings.zsh"
fi

# fix for snaps
# if [  -n "$(uname -a | grep Ubuntu)" ]; then
#   emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'
# fi

# zprof
