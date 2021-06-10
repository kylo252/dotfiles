#!/usr/bin/env bash

function __setup_defaults() {
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"

  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  export EDITOR=nvim

  export DOTBARE_DIR="$HOME/.dtf.git"
  export DOTBARE_TREE="$HOME"
}

function __setup_cli_colors() {
  export CLICOLOR=1
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
}

function __setup_xdg() {
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"
  export FNM_DIR="$XDG_DATA_HOME/fnm"
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
  export GNUPGHOME="$XDG_DATA_HOME/gnupg"
  export GOPATH="$XDG_DATA_HOME/go"
  export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
  export NPM_HOME="$XDG_DATA_HOME/npm"
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
  export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
}

function __setup_history() {
  export HISTCONTROL=ignoreboth
  export HISTFILE="$XDG_DATA_HOME/bash/history"
  export HISTFILESIZE=100000
  export HISTIGNORE="ls:ps:history"NIT=1
  export HISTSIZE=100000 # History size in memory
  export HISTTIMEFORMAT="%h %d %H:%M:%S "
  export LISTMAX=50       # The size of asking history
  export SAVEHIST=1000000 # The number of histsize
}

function __setup_fzf() {
  export FZF_DEFAULT_OPTS="--layout=reverse  --multi \
        --bind '?:toggle-preview' \
        --bind 'ctrl-a:select-all' \
        --bind 'ctrl-y:execute-silent(echo {+} | xcopy)' \
        --bind 'ctrl-e:execute(echo {+} | xargs -o vim)' \
        --bind 'ctrl-v:execute(code {+})' "
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | xbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
  # export FZF_DEFAULT_COMMAND='rg --files --hidden'
  export FZF_DEFAULT_COMMAND='fd --type f'
  export FZF_PREVIEW_DEFAULT_SETTING='--sync --height="80%" --preview-window="down:60%" --expect="ctrl-space" --header="C-Space: continue fzf completion"'
}

function __setup_misc() {
  export BAT_PAGER="less -RF"
  # https://github.com/sharkdp/bat/issues/652
  # export MANPAGER="sh -c 'col -bx | bat -l man -p'"

  # interactive search when using three dots
  export ENHANCD_DOT_ARG='...'

  export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240,italic,underline"
  export ZSH_AUTOSUGGEST_USE_ASYNC="ON"
  export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

  export ENHANCED_LAZY_COMPLETION=true
}

__setup_functions=(
  __setup_defaults
  __setup_cli_colors
  __setup_xdg
  __setup_history
  __setup_fzf
  __setup_misc
)

for func in "${__setup_functions[@]}"; do
  "$func"
  unset -f "$func"
done
unset __setup_functions

_bin_list=(
  "$HOME/.local/bin"
  "$HOME/local/bin"
  "$HOME/bin"
  "$CARGO_HOME/bin"
  "$GEM_HOME/bin"
  "$NPM_HOME/bin"
  "$GOPATH/bin"
)

for extra in "${_bin_list[@]}"; do
  PATH=$extra:$PATH
done
export PATH
unset _bin_list
