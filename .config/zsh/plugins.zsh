#!/usr/bin/env zsh

# load custom modules
source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

source "$XDG_DATA_HOME/zsh/plugins/znap/znap.zsh"

if [ -d "$XDG_CONFIG_HOME/rhel" ]; then
  source "$XDG_CONFIG_HOME/rhel/settings.sh"
fi

znap source kazhala/dotbare
znap source romkatv/powerlevel10k
znap source zdharma-continuum/fast-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab
znap source reegnz/jq-zsh-plugin
znap source RobSis/zsh-completion-generator

znap function _pip_completion pip 'eval "$(pip completion --zsh)"'
compctl -K    _pip_completion pip

znap eval zoxide 'zoxide init zsh'

if command -v vivid >/dev/null; then
  znap eval ls 'eval "export LS_COLORS=$(vivid -m 24-bit generate one-dark)"'
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  export XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.nix-profile/share/applications"
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
  znap install spwhitt/nix-zsh-completions
fi

znap eval fnm "fnm env --fnm-dir=$FNM_DIR --shell=zsh"

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
zstyle ':fzf-tab:*' switch-group ',' '.'

bindkey '^ ' autosuggest-accept

bindkey '^\ei' jq-complete

