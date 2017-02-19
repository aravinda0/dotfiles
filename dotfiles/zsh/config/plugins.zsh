# Refer: https://github.com/zplug/zplug/wiki


# Initialize plugin system
export ZPLUG_HOME=$DOTFILES_PATH/zsh/zplug
source $ZPLUG_HOME/init.zsh


# -------------------------------------------------------------------------------
# FZF
# -------------------------------------------------------------------------------

# Fetch fzf binary from release repo and make available as command
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf

# Use the fzf repo's helper shell scripts for key bindings and completion settings
zplug "junegunn/fzf", from:github, use:"shell/*.zsh"


# Use `ag` instead of default `find` command
if ag_cmd="$(type -p ag)" || [[ -z "$ag_cmd" ]]; then
  export FZF_DEFAULT_COMMAND='ag -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Sort history results by default, instead of chronological ordering - quicker matches
export FZF_CTRL_R_OPTS='--sort'

# Bind Ctrl-T functionality to Ctrl-P instead
bindkey '^p' fzf-file-widget


# -------------------------------------------------------------------------------
# Minimal - A simple, clean prompt theme with 'magic enter' capabilities
# -------------------------------------------------------------------------------

zplug 'subnixr/minimal'


# -------------------------------------------------------------------------------
# fzf-marks - Bookmark directories and use fzf to open them
# -------------------------------------------------------------------------------

# NOTE: There's a bug in the script for this that seems to look for `fzf-tmux` and
# fails. Modify the `fzfcmd()` function in there manually to return just 'fzf'.
zplug 'urbainvaes/fzf-marks'


# -------------------------------------------------------------------------------
# Finish zplug setup
# -------------------------------------------------------------------------------

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi


# Finally, load plugins and make available for use
zplug load
