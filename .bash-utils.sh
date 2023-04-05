#!/usr/bin/env bash

tmux_sessionize() {
	if [[ $# -eq 1 ]]; then
		selected=$1
	else
		selected=$(find ~/ignitevision ~/projects ~/practice ~/Documents ~/nvim-plugins -mindepth 1 -type d | fzf)
	fi

	if [[ -z $selected ]]; then
		exit 0
	fi

	selected_name=$(basename "$selected" | tr . _)
	parent_dir=$(basename $(dirname "$selected") | tr . _)
	target="$parent_dir-$selected_name"
	tmux_running=$(pgrep tmux)

	if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
		tmux new-session -s $target -c $selected
		exit 0
	fi

	if ! tmux has-session -t=$target 2> /dev/null; then
		tmux new-session -ds $target -c $selected
	fi

	tmux switch-client -t $target
}
