#!/usr/bin/env zsh

autoload -U compinit

compinit

compdef __dotbare_completion dotbare

compdef _cd __enhancd::cd

fpath=("$ZDOTDIR/modules" "${fpath[@]}")

# load custom modules
autoload -Uz kp

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select
