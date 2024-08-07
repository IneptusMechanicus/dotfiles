autoload -U colors && colors
autoload -Uz compinit && compinit

setopt PROMPT_SUBST
setopt ignore_eof

source '.utils.sh'

newline=$'\n'
PROMPT='╭ %B%{$fg[green]%}%n@%m %{$fg[blue]%}%~ %{$fg[yellow]%}$(parse_git_branch)%{$reset_color%}$(virtualenv_info)${newline}╰ > '

zstyle :compinstall filename '/home/ineptus/.zshrc'
compinit

bindkey -s ^f "tmux_sessionize\n"
