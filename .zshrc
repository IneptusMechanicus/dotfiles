#!/usr/bin/zsh
source "$HOME/.palette.sh"
source "$HOME/.aliases.sh"
source "$HOME/.vars.sh"
source "$HOME/.utils.sh"
autoload -U colors && colors
autoload -Uz compinit && compinit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory


setopt PROMPT_SUBST
setopt ignore_eof


newline=$'\n'
PROMPT='╭ %B%{$fg[green]%}%n@%m %{$fg[blue]%}%~ %{$fg[yellow]%}$(parse_git_branch) %{$reset_color%}$(virtualenv_info)${newline}╰ > '

zstyle :compinstall filename '/home/ineptus/.zshrc'
compinit

bindkey -s ^f "tmux_sessionize\n"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
