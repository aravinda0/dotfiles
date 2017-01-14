# Hint: In zsh, hit Ctrl-v and some key to get code for that key
# eg. Ctrl-v <Backspace> --> ^?
# \e : <esc>
# ^ : <ctrl>


# Easier switching to command mode
bindkey -M viins 'jk' vi-cmd-mode


# Choose vi 'word' for kill/move operations
autoload -U select-word-style
select-word-style bash


bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' backward-kill-word
bindkey '\e^w' backward-delete-word
bindkey '^u' backward-kill-line

bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line
bindkey -M viins '^y' vi-put-before
bindkey -M viins '^j' down-line-or-history
bindkey -M vicmd '^j' down-line-or-history
bindkey -M viins '^k' up-line-or-history
bindkey -M vicmd '^k' up-line-or-history
