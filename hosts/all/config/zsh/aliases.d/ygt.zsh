#!/usr/bin/env zsh

dir=~/code/ygt

ygtshell () {
    project=$(basename $PWD)
    file=~/dotfiles/nix/env/ygt/$project/shell.nix

    if [ -f $file ]; then
        nix-shell $file --command zsh
    else
        nix-shell ~/dotfiles/nix/env/ygt/ruby/shell.nix --command zsh
    fi
}

##### spa
spa () { cd $dir/spabreaks }
spaconsole () { spa && tmux new -s "spabreaks-console" "make console" }
spadev () { spa && tmux new -s "spabreaks-dev" "make dev" }
spaguard () { spa && tmux new -s "spabreaks-guard" "make guard" }
spadebug () { spa && tmux new -s "spabreaks-debug" "task debug-web" }
spagit () { spa && tmux new -s 'spabreaks-gitui' 'gitui' }
spatest () { spa && tmux new -s "spabreaks-test" "make test" }
spatestbash () { spa && tmux new -s "spabreaks-test-bash" "make test-bash" }
spabuild () { spa && tmux new -s "spabreaks-build" "make build" }
spapsql () { spa && tmux new -s "spabreaks-psql" "make psql" }
spacypress () { spa && tmux new -s "spabreaks-cypress" "make cypress" }

spa-routes () {
  output=$(spa && make routes)
  if [ "$#" -eq 0 ]; then
      echo $output
  else
    echo $output | grep $1
  fi
}

alias spabreaks="sesh connect spabreaks"
alias spa-db-migrate="spa && db-migrate"
alias spa-db-rollback="spa && db-rollback"
alias spa-db-redo="spa && make db-migrate-redo"
alias sparoutes="spa-routes"

##### wss
wss () { cd $dir/sales }
salesdev () { wss && tmux new -s "sales-dev" "make dev" }
alias sales="sesh connect sales"

##### btr
alias btr="cd $dir/booking-transform"
alias booking-transform="sesh connect booking-transform"
btr-dev () { btr && tmux new -s "btr-dev" "make dev" }
alias btrdev="btr-dev"
btr-console () { btr && tmux new -s "btr-console" "make console" }
alias btrconsole="btr-console"

##### wss-api
alias wss-api="cd $dir/wss-api"
alias wssapi="sesh connect wss-api"
wssapiconsole () { wss-api && tmux new -s "wss-api-console" "task console" }
wssapidev () { wss-api && tmux new -s "wss-api-dev" "task dev" }
wssapiguard () { wss-api && tmux new -s "wss-api-guard" "task guard" }

##### vrs
alias vrs="cd $dir/sb-voucher-redemptions"
alias voucher-redemptions="sesh connect sb-voucher-redemptions"
vrsconsole () { vrs && tmux new -s "sb-voucher-redemptions-console" "make console" }
vrsdev () { vrs && tmux new -s "sb-voucher-redemptions-dev" "make dev" }
vrsgit () { vrs && tmux new -s "sb-voucher-redemptions-git" "gitui" }
vrstestbash () { vrs && tmux new -s "sb-voucher-redemptions-test-bash" "make test-bash" }

##### mya
mya () { cd $dir/my-account }
myaccount-dev () { mya && tmux new -s "my-account-dev" "make dev" }
myaccount-test () { mya && distrobox-host-exec make test }

alias myaccount="sesh connect my-account"

alias myaccountdev="myaccount-dev"
alias myaccounttest="myaccount-test"
alias myaguard="mya && hmake guard"
alias myabuild="mya && hmake build"


# alias jira_url="gh pr view --json body | jq -r .body | sed -n 's/.*\(https:\/\/palatinategroup\.atlassian\.net\/browse\/SB-[0-9]*\).*/\1/p'"

jira_card_url () {
    number=$(git rev-parse --abbrev-ref HEAD | grep -o '[0-9]\{4,5\}')
    echo "https://palatinategroup.atlassian.net/browse/SB-$number"
}

jira_card () {
    xdg-open $(jira_card_url)
}
