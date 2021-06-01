#!/usr/bin/env zsh

source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

zstyle ':znap:*' plugins-dir "$XDG_DATA_HOME/znap/sources"

source "$XDG_DATA_HOME/znap/znap.zsh"

znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions

znap source zdharma/fast-syntax-highlighting

znap source romkatv/powerlevel10k

znap source b4b4r07/enhancd
znap source kazhala/dotbare
znap source bigH/git-fuzzy bin

znap compdef dotbare "_dotbare_completion_cmd"

znap eval pip-completion "source <(pip3 completion --zsh)"

znap eval kitty-completion "kitty + complete setup zsh | source /dev/stdin"

fpath=("$ZDOTDIR/modules" "${fpath[@]}")

source <(fnm env --fnm-dir="$XDG_DATA_HOME/fnm" --shell=zsh)

# test -d /home/linuxbrew/.linuxbrew && znap eval homebrew-env "/home/linuxbrew/.linuxbrew/bin/brew shellenv"

# load custom modules
autoload -Uz kp

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select

# expand alias just with <TAB> 
# TODO: keep a lookout for performance penalties or clashes with `autosuggestions`
zstyle ':completion:*' completer _expand_alias _complete _ignored

if command -v vivid >/dev/null; then
  export LS_COLORS="$(vivid -m 24-bit generate one-dark)"
fi
