#!/usr/bin/env zsh
# shellcheck disable

# TODO: check more examples from
# https://blog.sebastian-daschner.com/entries/zsh-aliases

alias cls='clear'

alias dtf='dotbare'

alias dta='dotbare fadd'
alias dtc='dotbare commit -m '
alias dte='dotbare fedit'
alias dtg='dotbare fgrep'
alias dtl='dotbare flog'
alias dtp='dotbare push'
alias dtr='dotbare fcheckout'
alias dts='dotbare fstat'

alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -laFq --color=auto'
alias ls='ls -FhN --color=auto --group-directories-first'

alias lzd='lazydocker'
alias lzg='lazygit'

alias paux='ps aux | rg'

alias potd='git push origin HEAD:refs/drafts/master' # used as 'potd'
alias potm='git push origin HEAD:refs/for/master'    # used as 'potm'

alias rd='rm -rd'

alias rn='ranger'
alias nv='nvim'

# insert relevant xkcd
alias archive='tar --create --gzip --verbose --file'

# workaround for interactive 'rm'
if alias rm &>/dev/null; then
  unalias rm
fi

alias -g L='| less -Rf'
alias -g B='| bat'
alias -g M='| bat --language man'
alias -g FZ='| fzf'
