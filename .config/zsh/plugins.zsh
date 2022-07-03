#!/usr/bin/env zsh

# load custom modules
source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

source "$XDG_DATA_HOME/zsh/plugins/znap/znap.zsh"

znap source kazhala/dotbare
znap source romkatv/powerlevel10k
znap source zdharma-continuum/fast-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab
znap source reegnz/jq-zsh-plugin
znap source RobSis/zsh-completion-generator
znap source soimort/translate-shell

znap function _pip_completion pip 'eval "$(pip completion --zsh)"'
compctl -K    _pip_completion pip

znap eval zoxide 'zoxide init zsh'

if command -v vivid >/dev/null; then
  export LS_COLORS="$(vivid -m 24-bit generate one-dark)"
fi

# doesn't seem to work on Darwin..
# znap eval fnm "fnm env --fnm-dir=$FNM_DIR --shell=zsh"
source <(fnm env --fnm-dir=${FNM_DIR} --shell=zsh)

autoload -Uz kp

# turn off git maintenance
zstyle ':znap:*:*' git-maintenance off
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group '[' ']'

znap eval luarock "luarocks path --no-bin 2>/dev/null"

if [ -d "/opt/homebrew" ]; then
  export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
  export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  znap eval brew "/opt/homebrew/bin/brew shellenv"
fi
