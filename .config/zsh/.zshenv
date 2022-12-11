#!/usr/bin/env zsh

function __setup_defaults() {
  export XDG_CACHE_HOME="$HOME/.cache"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"
  export XDG_STATE_HOME="$HOME/.local/state"
  # [ -z "$XDG_RUNTIME_DIR" ] && export XDG_RUNTIME_DIR="/run/user/$(id -u)"

  export LANG=en_US.UTF-8
  export LANGUAGE=en_US.UTF-8

  export EDITOR="nvim"

  export ZDOTDIR="$HOME/.config/zsh"

  export DOTBARE_DIR="$HOME/.dtf.git"
  export DOTBARE_TREE="$HOME"

  export FONTCONFIG_PATH=/etc/fonts

  # https://github.com/dandavison/delta/issues/497
  # this is actually broken
  # export LESS='-Rf'
}

function __setup_cli_colors() {
  export CLICOLOR=1
  export LESS_TERMCAP_mb=$(print -P "%F{cyan}")    #Start blinking
  export LESS_TERMCAP_md=$(print -P "%B%F{green}") #Start bold mode
  export LESS_TERMCAP_so=$(print -P "%F%K{magenta}") #Start standout mode
  export LESS_TERMCAP_us=$(print -P "%F{yellow}")  #Start underlining
  export LESS_TERMCAP_me=$(print -P "%f")          # reset
  export LESS_TERMCAP_me=$'\e[0m'                  # reset bold/blink
  export LESS_TERMCAP_se=$'\e[0m'                  # reset reverse video
  export LESS_TERMCAP_ue=$'\e[0m'                  # reset underline
  export GROFF_NO_SGR=1                            # for konsole and gnome-terminal
}

function __setup_xdg() {
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
  export FNM_DIR="$XDG_DATA_HOME/fnm"
  export GEM_HOME="$XDG_DATA_HOME/gem"
  export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
  export GNUPGHOME="$XDG_DATA_HOME/gnupg"
  export GOPATH="$XDG_DATA_HOME/go"
  export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
  export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
  export LESSHISTFILE="$XDG_STATE_HOME/less/history"
  export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
  export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
  export TERMINFO="$XDG_DATA_HOME/terminfo"
  export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
  export TMUX_CONFIG_DIR="$XDG_CONFIG_HOME/tmux"
  export TREE_SITTER_DIR="$XDG_CONFIG_HOME/tree-sitter"
  export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
  export ZK_NOTEBOOK_DIR="$HOME/notes/pages"
}

function __setup_history() {
  export HISTFILE="$XDG_STATE_HOME/zsh/history"
  export HISTSIZE=100000  # History size in memory
  export SAVEHIST=1000000 # The number of histsize
  export LISTMAX=50       # The size of asking history
}

function __setup_fzf() {
  export FZF_DEFAULT_COMMAND="fd --type f"
  export FZF_DEFAULT_OPTS=" \
    --layout=reverse  --multi \
    --cycle \
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

  export CTEST_PARALLEL_LEVEL=$(nproc 2>/dev/null)

  export MANPAGER='less -s -M +Gg'

  export VCPKG_DISABLE_METRICS=1
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
  "$XDG_DATA_HOME/nvim/mason/bin"
  )

for extra in "${bin_list[@]}"; do
  PATH=$extra:$PATH
done
export PATH
unset bin_list

# just in case latest zsh is not in '/usr/bin'
# it's probably unnecessary
SHELL="$(command -v zsh)"
export SHELL
