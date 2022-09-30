# path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# disable CTRL-s flow control
stty -ixon

# run TMUX on terminal start
#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -2
#fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz compinit
compinit

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions git pass autojump)

# User configuration

#export PATH=":/usr/local/heroku/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/pawel/.rvm/bin:/home/pawel/.rvm/bin:/home/pawel/.composer/vendor/bin:/home/pawel/.local/bin/:/home/pawel/.npm-global/bin/:/home/pawel/.xmonad/bin"
export PATH="/home/pawel/bin:/home/pawel/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/pawel/.local/bin/:/home/pawel/.npm-global/bin/:/home/pawel/.xmonad/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Path to your oh-my-zsh installation.
# Path to your oh-my-zsh installation.
# Path to your oh-my-zsh installation.
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
. ~/.aliases
. ~/.dir_colors

#if [[ "$TERM" != "screen" ]] &&
#        [[ "$SSH_CONNECTION" == "" ]]; then
#    # Attempt to discover a detached session and attach
#    # it, else create a new session
#
#    WHOAMI=$(whoami)
#    if tmux has-session -t $WHOAMI 2>/dev/null; then
#        tmux -2 attach-session -t $WHOAMI
#    else
#        tmux -2 new-session -s $WHOAMI
#    fi
#else
#
#    # One might want to do other things in this case,
#    # here I print my motd, but only on servers where
#    # one exists
#
#    # If inside tmux session then print MOTD
#    MOTD=/etc/motd.tcl
#    if [ -f $MOTD ]; then
#        $MOTD
#    fi
#fi

### System administration
# unzipping downloaded fonts to the ./fonts directory
unzipFont() {
    unzip $1 -d ~/.fonts/$2
    rm $1
}

# cd to directory in clipboard
cdv() {
    cd `xclip -o`
}

# Editing files by making a backup first
bedit() {
    date="`date -I`"
    cp $1 ${1}.backup$date
    vim $1
}

sbedit() {
    date="`date -I`"
    sudo cp $1 ${1}.backup$date
    sudo vim $1
}

##### web development tasks ###
npmInstallSaveDev() {
    npm install --save-dev $*
}

npmInstallSave() {
    npm install --save $*
}

###### calibre #####
# send to kindle
calibreSend() {
    echo 'Sending file by email'
    calibre-smtp pawel.lisewski@gmail.com pawel.lisewski@kindle.com "CLI ebook" -r smtp.gmail.com -u pawel.lisewski@gmail.com -p dailymeditation -e SSL --port 465 -s $1 -a $1
}

# add to calibre library
calibreAdd() {
    calibredb add $1
    rm $1
}

# convert epub to mobi
calibreConvert() {
    ebook-convert ${1} ${1%.*}.mobi
}

##### Development #####
# open chrome at localhost
lhost () {
  if [ -z ${1} ];
  then xdg-open http://localhost:$f;
  else xdg-open http://localhost:${1};
  fi
}
# launch tmux panes and start servers for testing
backTest() {
  cd ~/Code/tests/back/$currentTest
  tmux rename-window 'BACK'
  tmux split-window -h -c "#{pane_current_path}"
  php artisan serve
}
frontTest() {
  cd ~/Code/tests/front/$currentTest
  tmux rename-window 'FRONT'
  tmux split-window -h -c "#{pane_current_path}"
  npm run dev
}
# lunch tmux panes for development
rundev() {
  cd ~/Code/$currentDev
  tmux rename-window 'DEV'
  tmux split-window -h -c "#{pane_current_path}"
  gv. && npm start -s
}
# unzip fontello /font and /css to working directories
fontello() {
  echo 'Getting filename'
  name=${1%.*}
  echo 'Removing old css'
  rm -rf $currentTest/resources/assets/css/fontello
  unzip -j ./$1 ''$name'/css/*' -d $currentTest/resources/assets/css/fontello
  echo 'Removing old fonts'
  rm -rf $currentTest/resources/assets/fonts/fontello
  unzip -j ./$1 ''$name'/font/*' -d $currentTest/resources/assets/fonts/fontello
  echo 'Removing zip file'
  rm $1
  echo 'New css and fonts applied'
}

# open chrome in new window
mindmup() {
  google-chrome --new-window $1
}

# cURL
curl-post-json() {
  curl -X POST -H "Content-type: application/json" $1 -d $2 | python -mjson.tool
}

curl-json() {
curl $1 | python -m json.tool
}

#find
fnd() {
  find -name "*$1*"
}

#mkdir && cd
mkcd() {
  mkdir $1 && cd $1
}

#ibus

. ~/.shrc

# bash functions
function join { local IFS="$1"; shift; echo "$*"; }

# npm typescript
nst() {
  XS=()
  for var in "$@"
  do
    XS+="$var"
    XS+="@types/$var"
  done
  npm install --save $(join " " ${XS[@]})
}

# web-dev-view
wdv () {
  google-chrome-stable --new-window http://localhost:8000
  google-chrome-stable --new-window http://localhost:8000
}

# ssh authentication with gpg
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export EDITOR=vim

export FZF_DEFAULT_COMMAND='fd --type f'
