#!/usr/bin/env zsh
# shellcheck disable

# custom modules

if ! command -v fnm --version 2 &>/dev/null; then
  eval "$(fnm env --fnm-dir=$XDG_DATA_HOME/fnm --shell=zsh 2 &>/dev/null)"
  fnm completions --shell=zsh >"$ZDOTDIR/modules/_fnm"
fi

fpath=("$ZDOTDIR/modules" "${fpath[@]}")

# load modules
autoload -Uz kp

autoload -U compinit

# Initialize the completion system with a cache time of 24 hours.
# typeset -g zcompdump="$HOME/.local/share/zsh/zcompdump"
#
# typeset -g comp_files=($zcompdump(Nm-24))
#
# if (( $#comp_files )) {
#   compinit -i -C -d $zcompdump
# } else {
#   compinit -i -d $zcompdump
# }

compinit

unset zcompdump
unset comp_files

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
