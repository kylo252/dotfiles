# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/ekhhaga/local/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/ekhhaga/local/fzf/shell/key-bindings.bash"

export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore --files'

