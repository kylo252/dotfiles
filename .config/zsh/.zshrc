#!/usr/bin/env zsh

# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# There's a problem with starting instant-prompt and creating a new tmux session
if [ -z "$VIRTUAL_ENV" ] && [ -n "$TMUX" ]; then
  if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

if [ -n "$TMUX" ] || [ -n "$TERM_PROGRAM" ]; then
  source "$XDG_CONFIG_HOME/zsh/.p10k.lean.zsh"
else
  source "$XDG_CONFIG_HOME/zsh/.p10k.default.zsh"
fi

_bin_list=(
  "$HOME/.local/bin"
  "$HOME/local/bin"
  "$HOME/bin"
  "$CARGO_HOME/bin"
  "$GEM_HOME/bin"
  "$NPM_HOME/bin"
  "$GOPATH/bin"
  )

for extra in "${_bin_list[@]}"; do
  PATH=$extra:$PATH
done
export PATH
unset _bin_list

# just in case latest zsh is not in '/usr/bin'
# it's probably unnecessary
SHELL="$(command -v zsh)"
export SHELL

source "$ZDOTDIR/opts.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/functions.zsh"

source "$ZDOTDIR/plugins.zsh"

if [ -d "$XDG_CONFIG_HOME/rhel" ]; then
  source "$XDG_CONFIG_HOME/rhel/settings.zsh"
fi

# zprof
