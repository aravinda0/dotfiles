

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -lah'


alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'


alias o='gio open'


alias vim='nvim'
alias ag='rg'
alias py="ptpython"


alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'


# git helpers
alias gs='git status'
alias gd="git diff"
alias gds="git diff --staged"
alias gco='git checkout'
alias gr='git restore'
alias grs='git restore --staged'
alias ga='git add'
alias gc='git commit'
alias gci='git commit -m'
alias gp='git push'

# `cd` to git repo root
alias groot='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
