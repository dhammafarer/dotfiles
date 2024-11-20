#!/usr/bin/env zsh

gh_pr_create() {
    title=$1
    body=$2
    gh pr create --title "$title" --body "$body" "${@:3}"
}

alias prs="gh f -p; sgh"
alias prw="gh pr view --web"
alias prc="gh_pr_create"
