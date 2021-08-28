#!/usr/bin/env zsh

# load custom modules
source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"
[ -f "$LFCD" ] && source "$LFCD"

source "$XDG_DATA_HOME/zsh/plugins/znap/znap.zsh"

znap source kazhala/dotbare

znap source romkatv/powerlevel10k

znap source zdharma/fast-syntax-highlighting

znap source zsh-users/zsh-autosuggestions

znap source zsh-users/zsh-completions

znap source Aloxaf/fzf-tab

znap fpath dotbare "_dotbare_completion_cmd"

znap eval pip-completion "pip completion --zsh  # $PYENV_VERSION"
# znap eval pip-completion "source <(pip3 completion --zsh)"

znap eval zoxide 'zoxide init zsh'

# TODO: use znap for this
if command -v vivid >/dev/null; then
  export LS_COLORS="$(vivid -m 24-bit generate one-dark)"
fi

source <(fnm env --fnm-dir="$XDG_DATA_HOME/fnm" --shell=zsh)

