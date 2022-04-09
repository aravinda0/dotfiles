# -------------------------------------------------------------------------------
# History
# -------------------------------------------------------------------------------

HISTFILE="$HOME/.zhistory"
HISTSIZE=100000
SAVEHIST=100000

# Keep adding commands to history file as we execute them instead of waiting for
# shell to exit. If we execute a command, then open a new shell, that last executed
# command should be available in history.
setopt INC_APPEND_HISTORY

# Don't share history between sessions
setopt NO_SHARE_HISTORY

# Don't display duplicates of lines already found
setopt HIST_FIND_NO_DUPS

# Remove older entry from history if it matches newly added entry
setopt HIST_IGNORE_ALL_DUPS

# When writing out history file, older commands that duplicate newer ones are omitted
setopt HIST_SAVE_NO_DUPS


# -------------------------------------------------------------------------------
# Directories
# -------------------------------------------------------------------------------

# Automatically `cd` into directory if the entered command was just a directory name
setopt AUTO_CD

# `cd` should push old directory on to stack
setopt AUTO_PUSHD

# Prevent duplicates on stack
setopt PUSHD_IGNORE_DUPS

# Don't print directory name on doing `pushd`
setopt PUSHD_SILENT


# -------------------------------------------------------------------------------
# Cursor
# -------------------------------------------------------------------------------

_fix_cursor() {
   echo -ne '\e[5 q'
}

# Helps fix issues in some environments where cursor doesn't seem to be visible in
# vi-mode. Also helps keeps things consistent between vim and zsh with how cursor looks in
# insert vs vi modes.
precmd_functions+=(_fix_cursor)
