#!/usr/bin/env bash

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

tmux_sessionize() {
	if [[ $# -eq 1 ]]; then
		selected=$1
	else
		selected=$(find ~/ignitevision ~/projects ~/practice ~/nvim-plugins ~/.config ~/Documents/Personal -mindepth 1 -maxdepth 2 -type d | fzf)
	fi

	if [[ -z $selected ]]; then
		return 0
	fi

	selected_name=$(basename "$selected" | tr . _)
	parent_dir=$(basename $(dirname "$selected") | tr . _)
	target="$parent_dir-$selected_name"
	tmux_running=$(pgrep tmux)

	if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
		tmux new-session -s $target -c $selected
		return 0
	fi

	if ! tmux has-session -t=$target 2> /dev/null; then
		tmux new-session -ds $target -c $selected
	fi

	tmux switch-client -t $target || tmux attach -t $target
}

#Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ll='ls -alF --color=auto'
alias ls='ls --color=auto'


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
