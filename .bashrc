export PS1="╭ \[\e[1;32m\]\u@\h: \[\e[1;34m\]\w\[\e[0m\]\[\e[1;33m\] \$(parse_git_branch)\[\e[0m\]\n╰ > "

source /etc/profile.d/bash_completion.sh
source ~/.bash-utils.sh

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

#Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -alF --color=auto'
alias ls='ls --color=auto'
alias nvim-dev-mode='nvim --cmd "set rtp+=./"'
alias spotify="/home/ineptus/.cargo/bin/spt"
alias tmux-sessionize='$(tmux_sessionize)'

bind -x '"\C-f": tmux-sessionize' 2>/dev/null

#Environment Variables
export TERM='tmux-256color'
export EDITOR='nvim'
export VISUAL='nvim'
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

source ~/.bash-work
