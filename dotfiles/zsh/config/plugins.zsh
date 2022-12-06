
# -------------------------------------------------------------------------------
# Zim
# -------------------------------------------------------------------------------

# Initialize plugin system
export ZIM_HOME=$HOME/.zim

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh


# -------------------------------------------------------------------------------
# FZF
# -------------------------------------------------------------------------------

# Source fzf helpers from installation site
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Use `rg` instead of default `find` command
if rg_cmd="$(type -p rg)" || [[ -z "$rg_cmd" ]]; then
  # export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude "{.git,node_modules,.venv}"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Sort history results by default, instead of chronological ordering - quicker matches
export FZF_CTRL_R_OPTS='--sort'

# Bind Ctrl-T functionality to Ctrl-P instead
bindkey '^p' fzf-file-widget


# -------------------------------------------------------------------------------
# fzf-marks - Bookmark directories and use fzf to open them
# -------------------------------------------------------------------------------

source $DOTFILES_PATH/zsh/external/fzf-marks/fzf-marks.plugin.zsh


# --------------------------------------------------------------------------------
# zimfw minimal theme
# --------------------------------------------------------------------------------

# Prompt indicator for vi normal mode
export MNML_NORMAL_CHAR=•
