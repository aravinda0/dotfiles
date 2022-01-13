

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -lah'


alias rm='rm -i'


alias o='gio open'


alias vim='nvim'
alias ag='rg'


alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'


# git helpers
alias gs='git status'
alias gd="git diff"
alias gds="git diff --staged"
alias gco='git checkout'
alias ga='git add'
alias gci='git commit -m'
alias gcm='git commit'
alias gp='git push'


# `cd` to git repo root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'

