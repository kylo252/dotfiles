#!/usr/bin/env bash
# shellcheck disable=1090,1091

export XDG_CONFIG_HOME="$HOME/.config"

source "$XDG_CONFIG_HOME/bash/exports.bash"

source "$XDG_CONFIG_HOME/bash/aliases.bash"

shopt -s histappend
shopt -s checkwinsize

if shopt -oq posix; then
  return
fi

extras=(
  /usr/share/bash-completion/bash_completion
  /etc/bash_completion
  "$XDG_CONFIG_HOME/fzf/fzf.bash"
)

for f in "${extras[@]}"; do
  test -f "$f" && source "$f"
done

eval "$(starship init bash)"
