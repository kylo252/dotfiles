# Setup fzf
# ---------
if [[ ! "$PATH" == */home/khgh/.local/share/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/khgh/.local/share/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/khgh/.local/share/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/khgh/.local/share/fzf/shell/key-bindings.bash"
