#!/usr/bin/env bash

alias where='type -a'
alias l='ls -CF --color=auto'
alias ls='ls -FhN --color=auto --group-directories-first'
alias la='ls -A --color=auto'
alias ll='ls -laFq --color=auto'
alias cls='clear'
alias rmd='rm -rd'
alias paux='ps aux | grep'
alias potm='git push origin HEAD:refs/for/master'    # used as 'potm'
alias potd='git push origin HEAD:refs/drafts/master' # used as 'potd'
alias dtf='git --git-dir="$HOME/.dtf.git" --work-tree="$HOME"'
alias rn='ranger'

# workaround for interactive 'rm'
if alias rm &>/dev/null; then
  unalias rm
fi
