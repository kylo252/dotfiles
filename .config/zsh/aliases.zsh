#!/usr/bin/env zsh
# shellcheck disable

# TODO: check more examples from
# https://blog.sebastian-daschner.com/entries/zsh-aliases

alias dtf='dotbare'

alias dta='dotbare fadd'
alias dtc='dotbare commit -m '
alias dte='dotbare fedit'
alias dtg='dotbare fgrep'
alias dtl='dotbare flog'
alias dtp='dotbare pull'
alias dtP='dotbare push'
alias dtr='dotbare fcheckout'
alias dts='dotbare fstat'

alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -laFq --color=auto'
alias ls='ls -FhN --color=auto --group-directories-first'

alias pre-dots-commit="GIT_DIR=$HOME/.dtf.git GIT_WORK_TREE=$HOME pre-commit"
alias lzd='lazygit --git-dir="$HOME/.dtf.git" --work-tree="$HOME"'
alias lzg='lazygit'
alias gu='gitui'
[ -e /etc/arch-release ] && alias -g paks='sudo pacman -S'

alias paux='procs aux | rg'

alias v='nvim'

# insert relevant xkcd
alias archive='tar --create --gzip --verbose --file'

# workaround for interactive 'rm'
if alias rm &>/dev/null; then
  unalias rm
fi

alias -g MN='| bat --language man'
alias -g FZ='| fzf'
