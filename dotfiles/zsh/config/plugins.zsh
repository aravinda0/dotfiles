
# Initialize plugin system
export ZIM_HOME=$HOME/.zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh


# -------------------------------------------------------------------------------
# FZF
# -------------------------------------------------------------------------------

# Source fzf helpers from installation site
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

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

source ${DOTFILES_PATH}/zsh/external/minimal/minimal.zsh


# -------------------------------------------------------------------------------
# fzf-marks - Bookmark directories and use fzf to open them
# -------------------------------------------------------------------------------

source $DOTFILES_PATH/zsh/external/fzf-marks/fzf-marks.plugin.zsh
