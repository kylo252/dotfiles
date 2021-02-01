#!/usr/bin/env zsh

alias bashconf="$EDITOR ~/.bashrc.user"
alias zshconf="$EDITOR ~/.zshrc.user"
alias cls='clear'

# probably useful to retain default git
alias dtg='git --git-dir="$HOME/.dtf.git" --work-tree="$HOME"'

alias dtf='dotbare'
alias dta='dotbare fadd'
alias dtc='dotbare commit -m '
alias dte='dotbare fedit'
alias dtl='dotbare flog'
alias dtp='dotbare push'
alias dtr='dotbare checkout'
alias dts='dotbare fstat'
alias htop='htop --user $USER'
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -laFq --color=auto'
alias ls='ls -FhN --color=auto --group-directories-first'
alias paux='ps aux | rg'
alias potd='git push origin HEAD:refs/drafts/master' # used as 'potd'
alias potm='git push origin HEAD:refs/for/master' # used as 'potm'
alias rmd='rm -rd'
alias vdir='vdir --color=auto'

# workaround for interactive 'rm'
if alias rm &> /dev/null
then
    unalias rm
fi

