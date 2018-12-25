

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'


alias rm='rm -i'


alias o='gio open'


alias vim='nvim'


alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tls='tmux ls'


# `cd` to git repo root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'


alias ag='rg'
