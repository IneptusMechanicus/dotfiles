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

source "$HOME/.aliases.sh"
source "$HOME/.vars.sh"
source "$HOME/.palette.sh"
source "$HOME/.utils.sh"

newline=$'\n'
PROMPT='╭ %B%{$fg[green]%}%n@%m %{$fg[blue]%}%~ %{$fg[yellow]%}$(parse_git_branch) %{$reset_color%}$(virtualenv_info)${newline}╰ > '

zstyle :compinstall filename '/home/ineptus/.zshrc'
compinit

bindkey -s ^f "tmux_sessionize\n"
