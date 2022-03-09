#!/usr/bin/env bash

alias v='nvim'

alias ls='ls -v --color=auto --group-directories-first'
alias l='ls -ACFN'
alias ll='ls -hlqAFN'

alias cls='clear'
alias rmd='rm -rd'
alias paux='ps aux | grep'

# insert relevant xkcd
alias archive='tar --create --gzip --verbose --file'

alias where='type -a'

# workaround for interactive 'rm'
alias rm &>/dev/null && unalias rm
