#!/usr/bin/env zsh

git_grep_focused_test() {
    git grep -E -e "f(it|describe|context) ['\"]" -e "Pry::ColorPrinter\.pp\(\w+\)"
}

alias gfoc="git_grep_focused_test"
 
set_pr_base() {
    export GIT_BASE=$1
}

set_pr_base_from_gh() {
    output=$(gh pr view --json baseRefName,number)
    branch=$(echo $output | jq -r .baseRefName)
    number=$(echo $output | jq -r .number)

    if [ -e $branch ]; then
        unset GIT_BASE
        unset PR_NUMBER
    else
        export GIT_BASE=$branch
        export PR_NUMBER=$number
    fi
}

alias spr="set_pr_base"
alias sgh="set_pr_base_from_gh"

git_switch_create_ygt() {
    if [ $# -lt 2 ]; then
        echo "Need at least 2 arguments"
        exit 1
    elif ! [[ $1 =~ ^[0-9]+$ ]]; then
        echo "First argument must be a number"
        exit 1
    fi

    card_nr=$1
    card_name=${@:2}

    branch_name=$card_nr-$(echo $card_name | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

    git switch -c $branch_name
}

git_switch_create_variant() {
    git switch -c $(git branch --show-current)--$@
}

git_merge_variant() {
    git merge $(git branch --show-current)--$@
}

git_branch_delete_variant() {
    git branch -d $(git branch --show-current)--$@
}

git_get_master_branch_name() {
    git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

alias gac="git add . && git commit"
alias gacm="git add . && git commit -m"
alias gar="git_add_remote"
alias gca="git commit --amend"
alias gcir="git_create_init_repo"
alias gcl="git_clone_repo"
alias gclp="git_clone_repo_palekiwi"
alias gclr="git_clone_rpi"
alias gcr="git_create_repo"
alias glog="git log"
alias gpa="git remote | xargs -L1 git push --all"
alias gpgh="git push github"
alias gpo="git push -u origin"
alias gpod="git push -u origin dev"
alias gpom="git push -u origin main"
alias gprm="git push -u rpi main"
alias gpul="git pull origin main"
alias grar="git_remote_add_rpi"
alias grls="git_remote_ls_rpi"
alias grcr="git_remote_cr_rpi"
alias grr="rm -rf .git && git init"
alias grrc="git rm -r --cached ."
alias grv="git remote -v"
alias gs="git_switch"
alias gsl="git switch - && sgh"
alias gsar="git_submodule_add_role"
alias gsc="git switch -c"
alias gscy="git_switch_create_ygt"
alias gscv="git_switch_create_variant"
alias gbdv="git_branch_delete_variant"
alias gsd="git switch dev"
alias gsm="git_get_master_branch_name | xargs git switch && unset GIT_BASE && unset PR_NUMBER && git pull"
alias gsb='sgh && gs $GIT_BASE'
alias gmb='sgh && git merge $GIT_BASE'
alias gmv='git_merge_variant'
alias gsr="git_set_remote"
alias gst="git status"
alias gsts="git status --short"
alias gsur="git submodule update --remote"
alias nah="git reset --hard; git clean -dif;"
alias gbn="git rev-parse --abbrev-ref HEAD"
git_clone_repo() {
  git clone https://github.com/$1
}

git_clone_rpi() {
  git clone ssh://git@rpi:/srv/git/$1
}

git_switch() {
  git switch $1 && sgh
}

git_clone_repo_palekiwi() {
  git clone git@github.com:palekiwi/$1.git $2
}

git_clone_role_palekiwi() {
  cd ~/code/roles/ && git clone git@github.com:palekiwi/ansible-role-$1.git $1
}

git_submodule_add_role() {
  git submodule add git@github.com:palekiwi/ansible-role-$1.git $1
}

git_create_repo() {
  gh repo create $1 --public --source=. --remote=upstream --push
}

git_set_remote() {
  NAME=${1:-`basename $PWD`}
  git remote set-url origin git@github.com:palekiwi/$NAME.git
  git remote -v
}

git_add_remote() {
  NAME=${1:-`basename $PWD`}
  git remote add origin git@github.com:palekiwi/$NAME.git
  git remote -v
}

git_remote_add_rpi() {
  git remote add rpi git@rpi:/srv/git/$1
  git remote -v
}

git_remote_ls_rpi() {
    ssh git@rpi ls -la /srv/git
}

git_remote_cr_rpi() {
    ssh git@rpi git init --bare /srv/git/$1
}

git_create_init_repo() {
  git_create_repo &&
  git init &&
  git_add_remote
}
