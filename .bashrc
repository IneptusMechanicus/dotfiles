source .utils.sh

export PS1="╭ \[\e[1;35m\]\u@\h \[\e[1;34m\]\w\[\e[0m\]\[\e[1;33m\] \$(parse_git_branch) \n\e[0m\]╰ > "

bind '"\C-f":tmux_sessionize'
