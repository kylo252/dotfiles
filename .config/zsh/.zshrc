#!/usr/bin/env zsh

# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# There's a problem with starting instant-prompt and creating a new tmux session
if [ -z "$VIRTUAL_ENV" ] && [ -n "$TMUX" ]; then
  if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

source "$XDG_CONFIG_HOME/zsh/.p10k.lean.zsh"

function __setup_x11() {
  if [ -n "$SSH_CONNECTION" ]; then
    return
  fi
  # How to check if WSL1/2
  # https://github.com/microsoft/WSL/issues/4555#issuecomment-609908080
  if [ -d /run/WSL ] && [ ! -d /mnt/wslg ] ; then
    # How to set up working X11 forwarding on WSL2
    # https://stackoverflow.com/a/61110604
    DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    # PULSE_SERVER=tcp:$(echo /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL
    export DISPLAY
    source "$ZDOTDIR/utils/ssh-agent.zsh"
  fi
}

function __setup_history() {
  setopt EXTENDED_HISTORY   # Write the history file in the ":start:elapsed;command" format.
  setopt HIST_FCNTL_LOCK    # Use  system’s fcntl call where available (better performance)
  setopt HIST_IGNORE_SPACE  # Do not record an entry starting with a space.
  setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.
  setopt HIST_VERIFY        # Do not execute immediately upon history expansion.
  setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
  setopt SHARE_HISTORY      # Share history between all sessions.
}

function __setup_defaults() {
  setopt NO_BEEP # disable the goddamn beep!
  # setopt CORRECT              # Command auto-correction
  setopt IGNORE_EOF           # Prevent accidental C-d from exiting shell
  setopt INTERACTIVE_COMMENTS # Allow comments, even in interactive shells
  setopt LIST_PACKED          # Make completion lists more densely packed

  # https://unix.stackexchange.com/q/48577
  typeset -g WORDCHARS=${WORDCHARS/\//}
}

setup_functions=(
  __setup_history
  __setup_defaults
  __setup_x11
)

for func in "${setup_functions[@]}"; do
  "$func"
  unset -f "$func"
done
unset setup_functions

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/completions.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/keymaps.zsh"

# zprof
