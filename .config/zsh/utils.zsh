#!/usr/bin/env zsh

source "$XDG_CONFIG_HOME/fzf/fzf.zsh"

source "$XDG_CONFIG_HOME/lf/lf.zsh"

source "$XDG_DATA_HOME/zgenom/zgenom.zsh"

source "$ZDOTDIR/completions.zsh"

# if the init script doesn't exist
if ! zgenom saved; then

  zgenom load zsh-users/zsh-autosuggestions
  zgenom load zsh-users/zsh-completions src

  zgenom load zdharma/fast-syntax-highlighting

  zgenom load romkatv/powerlevel10k powerlevel10k

  zgenom load b4b4r07/enhancd
  zgenom load kazhala/dotbare

  zgenom load unixorn/autoupdate-zgen

  zgenom load StackExchange/blackbox

  # save all to init script
  zgenom save
fi
