#!/usr/bin/env zsh

dir=~/code/ygt

##### spa
spa () { cd $dir/spabreaks }
spa-shell () { spa && nix-shell ~/dotfiles/nix/env/ygt/spabreaks/shell.nix $@ }
spa-console () { spa && tmux new -s "spa-console" "make console" }
spa-dev () { spa && tmux new -s "spa-dev" "make dev" }
spa-guard () { spa && tmux new -s "spa-guard" "make guard" }
spa-debug () { spa && tmux new -s "spa-debug" "task debug-web" }
# spa-git () { spa-shell --command "tmux new -s 'spa-gitui' 'gitui'" }
spa-git () { spa && tmux new -s 'spa-gitui' 'gitui' }
spa-test () { spa && tmux new -s "spa-test" "make test" }
spa-test-bash () { spa && tmux new -s "spa-test-bash" "make test-bash" }
spa-build () { spa && tmux new -s "spa-build" "make build" }
spa-psql () { spa && tmux new -s "spa-psql" "make psql" }

alias spaconsole="spa-console"
alias sspashell="spa-shell --command zsh"
alias spadebug="spa-debug"
alias spadev="spa-dev"
alias spagit="spa-git"
alias spaguard="spa-guard"
alias spatest="spa-test"
alias spatestbash="spa-test-bash"
alias spa-db-migrate="spa && db-migrate"
alias spa-db-rollback="spa && db-rollback"
alias spa-db-redo="spa && make db-migrate-redo"
alias spa-routes="spa && make routes"
alias spabuild="spa-build"
alias spapsql="spa-psql"

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
vrs-console () { vrs && tmux new -s "vrs-console" "distrobox-host-exec make console" }
vrs-dev () { vrs && tmux new -s "vrs-dev" "distrobox-host-exec make dev" }
vrs-git () { vrs && tmux new -s "vrs-gitui" "gitui" }
vrs-test-bash () { vrs && tmux new -s "vrs-test-bash" "distrobox-host-exec make test-bash" }
alias vrsdev="vrs-dev"
alias vrsgit="vrs-git"
alias vrstestbash="vrs-test-bash"
alias vrsconsole="vrs-console"

##### mya
mya () { cd $dir/my-account }
mya-dev () { mya && tmux new -s "mya-dev" "distrobox-host-exec make dev" }
mya-test () { mya && distrobox-host-exec make test }

alias myadev="mya-dev"
alias myatest="mya-test"
alias myaguard="mya && hmake guard"
alias myabuild="mya && hmake build"
