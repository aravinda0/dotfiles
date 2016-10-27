
# Load autocomplete config provided in fzf repo
[[ $- == *i* ]] && source "$FZF_INSTALL_PATH/fzf/shell/completion.zsh" 2> /dev/null

# Load key bindings provided in fzf repo
source "$FZF_INSTALL_PATH/fzf/shell/key-bindings.zsh"


# -------------------------------------------------------------------------------
# Customizations
# -------------------------------------------------------------------------------

# Bind fzf's Ctrl-T functionality to Ctrl-P instead
bindkey '^p' fzf-file-widget
