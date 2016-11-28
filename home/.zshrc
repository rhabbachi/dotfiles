# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
export EDITOR="vim"
export VISUAL=$EDITOR

### PATHS ###
# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"
# Android SDK
export PATH="$HOME/Programs/Android/Sdk/tools:$PATH"
export PATH="$HOME/Programs/Android/Sdk/platform-tools:$PATH"


# Go lang
export GOPATH="$HOME/.go/"
export PATH="$HOME/.go/bin/:$PATH"

# For Java application
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# Disable OH-MY-ZSH updates
export DISABLE_AUTO_UPDATE="true"

# Check if zplug is installed
[[ -f $HOME/.zplug/init.zsh ]] || {
  echo "Installing zplug"
  curl -sL zplug.sh/installer | zsh
  source ~/.zplug/init.zsh && zplug update --self
}

zstyle ":zplug:tag" nice 10

source ~/.zplug/init.zsh

autoload -Uz is-at-least
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", nice:0

#Additional completion definitions for Zsh.
zplug "zsh-users/zsh-completions", depth:1, nice:0

# Bundles from the default repo (robbyrussell's oh-my-zsh).
# Core
## Aliases
zplug "plugins/common-aliases", from:oh-my-zsh
alias top="htop"
# Ping www.google.com 8 times
alias pingo="ping www.google.com -c 8"
alias date-time='date +%Y%m%d-%H%M%S'
alias clr="clear"
alias a2log="multitail -f /var/log/httpd/localhost.error.log"
alias a2dir="find . | xargs -I PATH bash -c \"sudo chown rhabbachi:http 'PATH'; [[ -f 'PATH' ]] && sudo chmod 664 'PATH' || sudo chmod 775 'PATH'\""

# Vim
zplug "plugins/vundle", from:oh-my-zsh
alias vim-clear="trash ~/.vimswap ~/.vimviews/ ~/.vimbackup ~/.vimundo"

function a2dir () {
find . \
\( -type f -exec sudo chown rhabbachi:http {}; sudo chmod 664 {} \; \) , \
\( -type d -exec sudo chown rhabbachi:http {}; sudo chmod 775 {} \; \)
}

function a2link() {
# TODO check nade for underscores and uppercases.
local site_name="$1"
if [ -e "$site_name" ]; then
  echo "Missing site name"
  return
fi
ln -sf `pwd` $HOME/public_html/$site_name
}
# PV
command -v pv >/dev/null 2>&1 && alias -g PV="| pv -trab |"

# Facebook path picker
command -v fpp >/dev/null 2>&1 && alias -g FPP="| fpp"

# Aliases
if command -v ag >/dev/null 2>&1; then
  alias ag="ag -i"
  alias aphp="ag --php"
  alias fphp="ag --php -l"
  alias ajs="ag --js"
  alias fjs="ag --js -l"
  alias acss="ag --saas --css --less"
  alias fcss="ag --saas --css --less -l"
fi
alias gf="git-flow"
alias gitg="setsid gitg"
alias gk="setsid gitk --all --branches"
command -v tree >/dev/null 2>&1 && alias trees='tree -L 3 | less'
alias diff='colordiff'
# Needs pkgfile installed
zplug "plugins/command-not-found", from:oh-my-zsh, if:"which pkgfile"
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
alias dog="colorize"
zplug "plugins/rsync", from:oh-my-zsh, if:"which rsync"

zplug "plugins/fasd", from:oh-my-zsh, lazy:true, nice:0
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# Jumpapp
zplug "mkropat/jumpapp", as:command, use:"jumpapp"

# Git
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/gitfast", from:oh-my-zsh, if:"which git"
zplug "plugins/git-extras", from:oh-my-zsh, if:"which git"
zplug "plugins/gitignore", from:oh-my-zsh, if:"which git"
zplug "Seinh/git-prune", if:"which git"
command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"
fpath=($ZPLUG_HOME/repos/github/hub-linux-amd64-2.2.2/etc/ $fpath)
alias gsm='git show -s --format=%B'

# Backup Home
zplug "rhabbachi/fd287c8537964e1b993b", \
  from:gist, as:command, \
  hook-build:"chmod u+x backup-home.attic", \
  use:"backup-home.attic"

## Node.js
zplug "plugins/npm", from:oh-my-zsh

## Ruby
zplug "plugins/gem", from:oh-my-zsh

# PHP
zplug "plugins/composer", from:oh-my-zsh

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting"

# Fish-like autosuggestions for zsh
#zplug "zsh-users/zsh-autosuggestions"

zplug "plugins/history", from:oh-my-zsh

# ZSH port of Fish shell's history search feature.
zplug "plugins/history-substring-search", from:oh-my-zsh

# Desktop notification on command compleation.
zplug "plugins/bgnotify", from:oh-my-zsh
bgnotify_threshold=10 ## set your own notification threshold
function bgnotify_formatted {

[ $1 -eq 0 ] && title="$(tmux display-message -p '#S') -- Completed after $3 sec" \
  || title="$(tmux display-message -p '#S') -- Failed after $3 sec"
[ $1 -eq 0 ] && icon="process-completed-symbolic" \
  || icon="process-error-symbolic"

notify-send "$title"  "$2" -i "$icon";
}

# Pass password manager.
zplug "plugins/pass", from:oh-my-zsh

# A utility to run commands within docker containers
zplug "ahoy-cli/ahoy", \
  from:gh-r, \
  as:command

# Load systemd plugin if using systemd.
zplug "plugins/systemd", from:oh-my-zsh, if:"pidof systemd"

if grep -q "Ubuntu|Debian" /etc/lsb-release >/dev/null 2>&1; then
  zplug "plugins/debian", from:oh-my-zsh
  export apt_pref="apt-get"
  unalias ag
elif [ -f /etc/arch-release ]; then
  zplug "plugins/archlinux", from:oh-my-zsh
  command -v pacaur >/dev/null 2>&1 && alias pacman="pacaur"
  # https://wiki.archlinux.org/index.php/Pacman_tips
  # '[r]emove [o]rphans' - recursively remove ALL orphaned packages
  alias pacro="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')"
  orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
      echo "No orphans to remove."
    else
      sudo pacman -Rns $(pacman -Qdtq)
    fi
  }
fi

# TMUX plugin
zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux"
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOQUIT=true

# Base16 Shell
zplug "chriskempson/base16-shell", use:"scripts/base16-monokai.sh"

# Better prompt
export DEFAULT_USER="rhabbachi"
zplug "bhilburn/powerlevel9k", as:theme
export POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir rbenv docker_machine vcs)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

# Homeshick
zplug "andsens/homeshick", use:"homeshick.sh"
fpath=($ZPLUG_HOME/repos/andsens/homeshick/completions $fpath)

# Drush compleation
export DRUSH_INI="$HOME/.drush/drush.ini"
# Compleation
if ! bashcompinit >/dev/null 2>&1; then
  autoload -U bashcompinit
  bashcompinit -i
fi
zplug "$HOME/.drush/drush.complete.sh", from:local

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Platform.sh CLI configuration
#zplug "$HOME/.composer/vendor/platformsh/cli/platform.rc", from:local

# Custom zsh config/commands
zplug "$HOME/.zplug/custom", from:local

# Colorization for mysql
zplug "horosgrisa/mysql-colorize"

# A utility to run commands within docker containers
zplug "Netflix-Skunkworks/go-jira", \
  from:gh-r, \
  as:command, \
  rename-to:"jira"

# A command-line fuzzy finder written in Go.
## Main go binary.
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:"fzf"
## Helper bash script.
zplug "junegunn/fzf", \
    as:command, \
    use:"bin/fzf-tmux"

# save all to init script
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

unalias rm
alias l="ls -lFh --group-directories-first"

# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
if [ ${ZSH_VERSION//\./} -ge 420 ]; then
  # open browser on urls
  _browser_fts=(htm html de org net com at cx nl se dk dk php)
  for ft in $_browser_fts ; do alias -s $ft=$BROWSER ; done

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts ; do alias -s $ft=$EDITOR ; done

  _image_fts=(jpg jpeg png gif mng tiff tif xpm)
  for ft in $_image_fts ; do alias -s $ft=$XIVIEWER; done

  _media_fts=(ape avi flv mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts ; do alias -s $ft=cvlc ; done

  #read documents
  alias -s pdf=acroread
  alias -s ps=gv
  alias -s dvi=xdvi
  alias -s chm=xchm
  alias -s djvu=djview

  #list whats inside packed file
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s tar="tar tf"
  alias -s tar.gz="echo "
  alias -s ace="unace l"
fi

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Open file with the right application
function open () {
setsid xdg-open $1
}

# AUTOSSH
command -v autossh >/dev/null 2>&1 && alias ssh='autossh -M 0 -o "ServerAliveInterval 45" -o "ServerAliveCountMax 2"'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fag() {
  local file
  file=$(\ag -l $1 | \fzf --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# https://wiki.archlinux.org/index.php/Systemd/User#PATH
systemctl --user import-environment PATH

## Ahoy Docker Nucivic env
function ahoydocker() {
  [[ $(docker-machine status) == "Stopped" ]] && docker-machine start default
  eval "$(docker-machine env default)"
  export VIRTUAL_HOST="default.docker"
  export AHOY_CMD_PROXY="DOCKER"
}

[[ $(docker-machine status) == "Running" ]] && { eval "$(docker-machine env default)"; export VIRTUAL_HOST="default.docker"; export AHOY_CMD_PROXY="DOCKER"; }

function currentworkspace() {
  echo $(wmctrl -d | gawk '{if ($2 == "*") print tolower($10)"_"($11)}')
}

# Open command in vim quickfix
function vimq () {
  vim -q <($@) +cw
}

# RVM
## Add RVM to PATH for scripting
export PATH="$HOME/.rvm/bin:$PATH"
## Load RVM into a shell session *as a function*
[[ -f "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
