#!/usr/bin/env zsh

dir=~/code/ygt

##### spa
spa () { cd $dir/spabreaks }
spashell () { nix-shell ~/dotfiles/nix/env/ygt/spabreaks/shell.nix --command zsh }
spaconsole () { spa && tmux new -s "spabreaks-console" "make console" }
spadev () { spa && tmux new -s "spabreaks-dev" "make dev" }
spaguard () { spa && tmux new -s "spabreaks-guard" "make guard" }
spadebug () { spa && tmux new -s "spabreaks-debug" "task debug-web" }
spagit () { spa && tmux new -s 'spabreaks-gitui' 'gitui' }
spatest () { spa && tmux new -s "spabreaks-test" "make test" }
spatestbash () { spa && tmux new -s "spabreaks-test-bash" "make test-bash" }
spabuild () { spa && tmux new -s "spabreaks-build" "make build" }
spapsql () { spa && tmux new -s "spabreaks-psql" "make psql" }

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
wss-dev () { wss && tmux new -s "wss-dev" "distrobox-host-exec make db-run && distrobox-host-exec make dev" }

alias wssdev="wss-dev"

##### btr
alias btr="cd $dir/booking-transform"
btr-dev () { btr && tmux new -s "btr-dev" "distrobox-host-exec make dev" }
alias btrdev="btr-dev"
btr-console () { btr && tmux new -s "btr-console" "distrobox-host-exec make console" }
alias btrconsole="btr-console"

##### vrs
alias vrs="cd $dir/sb-voucher-redemptions"
vrsconsole () { vrs && tmux new -s "sb-voucher-redemptions|-console" "make console" }
vrsdev () { vrs && tmux new -s "sb-voucher-redemptions|-dev" "make dev" }
vrsgit () { vrs && tmux new -s "sb-voucher-redemptions|-git" "gitui" }
vrstestbash () { vrs && tmux new -s "sb-voucher-redemptions|-test-bash" "make test-bash" }

##### mya
mya () { cd $dir/my-account }
mya-dev () { mya && tmux new -s "mya-dev" "distrobox-host-exec make dev" }
mya-test () { mya && distrobox-host-exec make test }

alias myadev="mya-dev"
alias myatest="mya-test"
alias myaguard="mya && hmake guard"
alias myabuild="mya && hmake build"
