#!/usr/bin/env zsh

source ~/.config/zsh/aliases.d/docker.zsh
source ~/.config/zsh/aliases.d/exa.zsh
source ~/.config/zsh/aliases.d/gh.zsh
source ~/.config/zsh/aliases.d/git.zsh
source ~/.config/zsh/aliases.d/ygt.zsh

nt () {
    cd ~/Notes && nvim +"lua require('kiwi').open_wiki_index()" index.md
}

alias cat="bat -p"
alias cdc="pwd | ctc"
alias chx="chmod +x"
alias ctc="cat_to_clipboard"
alias gu="gitui"
alias gud="gu ~/dotfiles"
alias gut="gu ~/tailnet"
alias ll="ls -la"
alias pc="pass -c"
alias rr="ranger"
alias sal="source ~/.aliases"  
alias update="home-manager switch --flake ~/dotfiles/nix"
alias v="nvim_fg"
alias xo="xdg-open"

alias pgpa="pass git remote | xargs -L1 pass git push --all"
alias pgpom="pass git push -u origin master"
alias pgpul="pass git pull origin master"
alias pi="pass_insert"

pass_insert () {
    len=$1
    name=$2
    pass generate -n $name $len 1> /dev/null
    pass edit $name
}

nvim_fg () {
    if [ -z "$(jobs | grep nvim)" ]; then
        nvim $@
    else
        fg
    fi
}

cat_to_clipboard () {
    bat -p $1 | xclip -selection clipboard
}
