#!/usr/bin/env zsh

alias gac="git add . && git commit"
alias gacm="git add . && git commit -m"
alias gar="git_add_remote"
alias gca="git commit --amend"
alias gcir="git_create_init_repo"
alias gcl="git_clone_repo"
alias gclp="git_clone_repo_palekiwi"
alias gclr="git_clone_rpi"
alias gcmd="git checkout master && git merge dev"
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
alias gs="git switch"
alias gsl="git switch -"
alias gsar="git_submodule_add_role"
alias gsc="git switch -c"
alias gsd="git switch dev"
alias gsm="git switch master"
alias gsr="git_set_remote"
alias gst="git status"
alias gsts="git status --short"
alias gsur="git submodule update --remote"
alias nah="git reset --hard; git clean -dif;"
git_clone_repo() {
  git clone https://github.com/$1
}

git_clone_rpi() {
  git clone ssh://git@rpi:/srv/git/$1
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

