#!/usr/bin/env zsh

function __setup_defaults() {
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"

  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  export EDITOR=nvim

  export ZDOTDIR="$HOME/.config/zsh"

  export DOTBARE_DIR="$HOME/.dtf.git"
  export DOTBARE_TREE="$HOME"

	# export ZGEN_INIT="$ZDOTDIR/init.zsh"
  export ZGEN_SOURCE="$XDG_DATA_HOME/zgenom"
  export ZGEN_AUTOLOAD_COMPINIT=1
}

function __setup_cli_colors(){
  export CLICOLOR=1  
  export LESS_TERMCAP_mb=$(print -P "%F{cyan}")
  export LESS_TERMCAP_md=$(print -P "%B%F{red}")
  export LESS_TERMCAP_me=$(print -P "%f%b")
  export LESS_TERMCAP_so=$(print -P "%F{magenta}")
  export LESS_TERMCAP_se=$(print -P "%K{black}")
  export LESS_TERMCAP_us=$(print -P "%U%F{green}")
  export LESS_TERMCAP_ue=$(print -P "%f%u")
}

function __setup_xdg() {
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  export ENHANCD_DIR="$XDG_DATA_HOME/enhancd"
  export FNM_DIR="$XDG_DATA_HOME/fnm"
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
  export GNUPGHOME="$XDG_DATA_HOME/gnupg"
  export GOPATH="$XDG_DATA_HOME/go"
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
  export NPM_HOME="$XDG_DATA_HOME/npm"
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/.ripgreprc"
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
}

function __setup_history() {
  export HISTFILE="$XDG_DATA_HOME/zsh/history"
  export HISTSIZE=100000  # History size in memory
  export SAVEHIST=1000000 # The number of histsize
  export LISTMAX=50       # The size of asking history
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
