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

  export FONTCONFIG_PATH=/etc/fonts
}

function __setup_cli_colors() {
  export CLICOLOR=1
  export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
}

function __setup_xdg() {
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  export FNM_DIR="$XDG_DATA_HOME/fnm"
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
  export GNUPGHOME="$XDG_DATA_HOME/gnupg"
  export GOPATH="$XDG_DATA_HOME/go"
  export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
  export NPM_HOME="$XDG_DATA_HOME/npm"
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
  export TEALDEER_CACHE_DIR="$XDG_CACHE_HOME/tldr"
  export TERMINFO="$XDG_DATA_HOME/terminfo"
  export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
  export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
  export TREE_SITTER_DIR="$XDG_CONFIG_HOME/tree-sitter"
  export ZK_NOTEBOOK_DIR="$HOME/notes/pages"
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
  export FZF_DEFAULT_COMMAND="fd --type f"
  export FZF_DEFAULT_OPTS=" \
    --layout=reverse  --multi \
    --bind '?:toggle-preview' \
    --bind 'ctrl-a:select-all' \
    --bind 'ctrl-y:execute-silent(echo {+} | xclip)' \
    --bind 'ctrl-e:execute(echo {+} | xargs -o nvim)' \
    --bind 'ctrl-x:execute(code {+})' "
  export FZF_CTRL_R_OPTS=" \
    --preview 'echo {}' \
    --preview-window down:3:hidden:wrap \
    --bind '?:toggle-preview' \
    --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip)+abort' \
    --header 'Press CTRL-Y to copy command into clipboard'\
    --border"
  export FZF_PREVIEW_DEFAULT_SETTING=" \
    --sync \
    --height='80%' \
    --preview-window='down:60%' \
    --expect='ctrl-space' \
    --header='C-Space: continue fzf completion'"
}

function __setup_misc() {
  export BAT_PAGER="less -RF"
  export BAT_THEME="TwoDark"

  export CMAKE_BUILD_TYPE=RelWithDebInfo
  export CMAKE_EXPORT_COMPILE_COMMANDS=1
  export CMAKE_GENERATOR=Ninja

  export DELTA_PAGER="less -RF"

  export MANPAGER='less -s -M +Gg'
}

setup_functions=(
  __setup_defaults
  __setup_cli_colors
  __setup_xdg
  __setup_history
  __setup_fzf
  __setup_misc
)

for func in "${setup_functions[@]}"; do
  "$func"
  unset -f "$func"
done
unset setup_functions

bin_list=(
  "$HOME/.local/bin"
  "$HOME/local/bin"
  "$HOME/bin"
  "$CARGO_HOME/bin"
  "$GEM_HOME/bin"
  "$NPM_HOME/bin"
  "$GOPATH/bin"
  "$XDG_CONFIG_HOME/rofi/bin"
  "$XDG_CONFIG_HOME/tmux/bin"
  )

for extra in "${bin_list[@]}"; do
  PATH=$extra:$PATH
done
export PATH
unset bin_list
