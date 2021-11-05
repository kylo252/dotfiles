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
      *.txz) tar Jxvf "$1" ;;
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
  [ -n "$TMUX" ] && local change="switch-client" || local change="attach-session"
  if [ $1 ]; then
    tmux "$change" -t "$1" 2>/dev/null || (tmux new-session -d -s "$1" && tmux "$change" -t "$1"); return
  fi
  local session="$(tmux list-sessions -F '#{session_name}' 2>/dev/null | fzf --exit-0)" &&  tmux "$change" -t "$session" || echo "No sessions found."
}

function ts() {
  local target="${1:-default}"
  smug start $target --attach
}

# an alias is not enough since we can only pass `depth` flag as a git command
function grc() {
  [ -n "$1" ] || echo "argument missing" || exit 1
  set -x
  gh repo clone "$1" -- --depth=1
}

function nf-download() {
  set -x
  local FONTS_DIR="$HOME/.local/share/fonts"
  local REQ_FONT_DIR="$FONTS_DIR/$1"
  mkdir -p "$REQ_FONT_DIR"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/"$1".zip -O "$REQ_FONT_DIR"/"$1".zip || exit 1
  cd "$REQ_FONT_DIR"
  unzip "$1".zip -d "$REQ_FONT_DIR" || exit 1
  fd 'Windows' -x rm 2</dev/null
  fc-cache -fv
}

function cpr() {
  rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 "$@"
}

function jqz(){
  emulate -L bash
  set -x
  args="${2:-}"
  file="$1"
  jq --color-output "$args" "$file" | fzf --ansi
}

function mvr() {
  rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files "$@"
}

function pprint() {
  [ -z "$1" ] && echo "invalid argument" && return 1
  echo "$1" | sed -e 's/\:/\n/g' | fzf
}

# find-in-file - usage: fif <SEARCH_TERM> <target>
function fif() {
  [ ! "$#" -gt 0 ] && echo "please provoide an argument, these are pass to rg directly" && return 1
  local initial_query="$@"
  local rg_prefix="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$rg_prefix '$initial_query'" \
    fzf --bind "change:reload:$rg_prefix {q} || true" \
        --ansi --disabled --query "$initial_query" \
        --bind 'ctrl-o:execute:${EDITOR:-vim} <(xdg {1}) > /dev/tty' \
  --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2 | awk -F":" '{ printf("%s +%s\n",$1,$2) }'
        # --layout=reverse | xargs "$EDITOR"

}

# TODO: add the ability to open in an editor
function fif-v2() {
  [ ! "$#" -gt 0 ] && echo "please provoide an argument, these are pass to rg directly" && return 1
  local initial_query="$@"
  local rg_prefix="rg --column --line-number --no-heading --color=always --smart-case "
  FZF_DEFAULT_COMMAND="$rg_prefix '$initial_query'" \
    fzf --bind "change:reload:$rg_prefix {q} || true" \
    --ansi --phony --query "$initial_query" \
    --height=50% --layout=reverse --preview "$XDG_CONFIG_HOME/fzf/helper/previewer.sh $PWD/{}" |
    awk -F ":" -v home="$PWD" '{ print home "/" $1 ":" $2 }' 
}

# zsh force reset
function zfr() {
  fd . "$ZDOTDIR" --hidden -e zwc -x rm 
  fd . "$XDG_CACHE_HOME/zsh" --type file --hidden -x rm 
  znap restart
}

# TODO not sure what this does
# function luamake() {
#   "$XDG_DATA_HOME"/nvim/lspinstall/lua/3rd/luamake/luamake "$@"
# }

gh-latest-release(){
  local repo="$1"
  gh api "repos/$repo/releases/latest" --jq '.assets[].browser_download_url'
}

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
