#!/usr/bin/env zsh

# ChrisTitusTech/zsh/blob/master/aliasrc
# ex - archive extractor
# usage: ex <file>
function ex() {
  if [ -f "$1" ]; then
    case $1 in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.tar.xz) tar xJf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.Z) uncompress "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function ta() {
  if [ -n "$1" ]; then TARGET="-t $1"; fi
  tmux attach $TARGET
}

function ts() {
  TARGET="default"
  if [ -n "$1" ]; then
    TARGET="$1"
  fi
  smug start $TARGET --attach
}

function cpr() {
  rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 "$@"
}

function mvr() {
  rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files "$@"
}

function pprint() {
  [ -z "$1" ] && echo "invalid argument" && return 1
  echo "$1" | sed -e 's/\:/\n/g' | fzf
}

# find-in-file - usage: fif <SEARCH_TERM>
function fif() {
  [ ! "$#" -gt 0 ] && echo "No arguments!!" && return 1
  rg "$1" "$2" --vimgrep --color ansi | fzf --ansi \
    --preview "rg --smart-case --pretty --context 10 '$1' {}"
}

# TODO: add the ability to open in an editor
function ifzf() {
  INITIAL_QUERY="$@"
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
    --ansi --phony --query "$INITIAL_QUERY" \
    --height=50% --layout=reverse --preview "$XDG_CONFIG_HOME/fzf/helper/previewer.sh $PWD/{}" |
    awk -F ":" -v home="$PWD" '{ print home "/" $1 ":" $2 }' 
}

# reload by using F5
function reset-zsh() {  
  znap restart 
}
zle -N reset-zsh
bindkey "${terminfo[kf5]}" reset-zsh

# TODO not sure what this does
# function luamake() {
#   "$XDG_DATA_HOME"/nvim/lspinstall/lua/3rd/luamake/luamake "$@"
# }

_zlf() {
 emulate -L zsh
  local d=$(mktemp -d) || return 1
  {
    mkfifo -m 600 $d/fifo || return 1
    tmux split -bf "echo {ZLE_FIFO}>$d/fifo; echo $ZLE_FIFO > /tmp/lfc.log; export ZLE_FIFO; exec lf" || return 1
    local fd
    exec {fd}<$d/fifo
    zle -Fw $fd _zlf_handler
  } always {
    rm -rf $d
  }
}

_zlf_handler() {
  emulate -L zsh
  local line
  if ! read -r line <&$1; then
    zle -F $1
    exec {1}<&-
    return 1
  fi
  eval $line
  zle -R
}
