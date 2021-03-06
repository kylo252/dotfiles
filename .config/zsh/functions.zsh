#!/usr/bin/env zsh

function cf() {
    rg --files ~/.config --type zshrc --type sh --type vim | fzf | xargs -r "$EDITOR" 
}

function sf() {
    rg --files "/repo/$USER/scripts" ~/.scripts --type sh --type py | fzf | tr -d '\n' | xclip -selection clipboard 
}

function ff() { 
    rg --vimgrep "$0" | fzf 
}

     
# find-in-file - usage: fif <SEARCH_TERM>
function fif() {
    [ ! "$#" -gt 0 ] && echo "No arguments!!" && return 1
    rg "$1" "$2" --vimgrep --color ansi | fzf --ansi \
        --preview "rg --smart-case --pretty --context 10 '$1' {}"
}

function mlf () {
    [ ! "$#" -gt 0 ] && echo "No arguments!!" && return 1
    module --color=auto avail "$1" | fzf 
}

function cpr() {
  rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 "$@"
} 

function mvr() {
  rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files "$@"
}

function pprint () {
    [ -z "$1" ] && echo "invalid argument" && return 1
    echo "$1" | sed -e 's/\:/\n/g' | fzf 
}

function ifzf() {
    INITIAL_QUERY=""
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
      fzf --bind "change:reload:$RG_PREFIX {q} || true" \
          --ansi --phony --query "$INITIAL_QUERY" \
          --height=50% --layout=reverse  --preview 'bat --style=numbers --color=always --line-range :500 {}'
}

alias fzfbat='fzf --preview "bat --color=always {}"'

function fuzzy_open_file() {
    local dir_glob file_glob
    if [ -n "$1" ]; then
        dir_glob="**/*$1*/**"
        file_glob="*$1*"
    fi
    file=$(rg --files --iglob "$dir_glob" --iglob "$file_glob" 2>/dev/null | fzfbat --multi -1 -0) \
        && file=$(echo $file | tr '\n' ' ') \
        && eval "$EDITOR $file"
    }

function fuzzy_search_open_file() {
	local editor depth
	editor="$1"
	depth="$2"
	shift ; shift

	local search="rg --hidden -l -i -F '$1'"
	if [ "$depth" -ne -1 ]; then
	  search="$search --max-depth $depth"
	fi

	file=$(eval "$search" 2>/dev/null | fzf -0 -1 --preview "$XDG_CONFIG_HOME/fzf/helper/previewer.sh '$1' '{}'" --multi) \
	  && file=$(echo $file | tr '\n' ' ') \
	  && eval "$editor $file"
    }

function set_fzf_multi() {
  local no_multi="$1"
  if [[ -z "${no_multi}" ]]; then
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --multi"
  else
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --no-multi"
  fi
}

function fz_rg() {
  local FZF_DEFAULT_OPTS="
      $FZF_DEFAULT_OPTS
      --ansi
      --cycle
      --exit-0"
  local header="${1:-select matches to edit}"
  local delimiter="${2:-3}"
  set_fzf_multi "$2"
  rg --line-number . \
    | fzf --delimiter : --nth "${delimiter}".. --header="${header}" \
        --preview "$XDG_CONFIG_HOME/fzf/helper/previewerV2.sh $PWD/{}" \
    | awk -F ":" -v home="$PWD" '{
        print home "/" $1 ":" $2
      }'
}

function fz_rg_t() {
  local FZF_DEFAULT_OPTS="
      $FZF_DEFAULT_OPTS
      --ansi
      --cycle
      --exit-0"
  local q_type="$1"
  local delimiter="${2:-3}"
  set_fzf_multi "$2"
  rg --line-number --type-add "$q_type:*.$q_type" -t$q_type . \
    | fzf --delimiter : --nth "${delimiter}".. \
        --preview "$XDG_CONFIG_HOME/fzf/helper/previewerV2.sh $PWD/{}" \
    | awk -F ":" -v home="$PWD" '{
        print home "/" $1 ":" $2
      }'
}

# reload by using F5
function exec-zsh() { exec zsh <$TTY; }
zle -N exec-zsh
zmodload zsh/terminfo
bindkey "${terminfo[kf5]}" exec-zsh


