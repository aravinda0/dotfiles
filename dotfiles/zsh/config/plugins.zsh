
# Initialize plugin system
export ZIM_HOME=$HOME/.zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh


# -------------------------------------------------------------------------------
# FZF
# -------------------------------------------------------------------------------

# Source fzf helpers from installation site
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Use `rg` instead of default `find` command
if rg_cmd="$(type -p rg)" || [[ -z "$rg_cmd" ]]; then
  # export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude "{.git,node_modules}"'
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


# -------------------------------------------------------------------------------
# asdf - Manage different local/global versions of various programs
# -------------------------------------------------------------------------------

# This should be after any other config that tweaks paths to find language binaries.
source $DOTFILES_PATH/asdf/external/asdf/asdf.sh
# source $DOTFILES_PATH/asdf/external/asdf/completions/_asdf
