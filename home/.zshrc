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

# Go lang
export GOPATH="$HOME/.go/"
export PATH="$HOME/.go/bin/:$PATH"

# For Java application
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# Disable OH-MY-ZSH updates
export DISABLE_AUTO_UPDATE="true"

# Check if zplug is installed
[[ -d ~/.zplug ]] || {
  curl -fLo ~/.zplug/zplug --create-dirs https://git.io/zplug
  source ~/.zplug/zplug && zplug update --self
}
source $HOME/.zplug/zplug
# https://github.com/b4b4r07/zplug#let-zplug-manage-zplug
zplug "b4b4r07/zplug"

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
alias a2dir="find . -type d | xargs -I dir bash -c 'sudo chown rhabbachi:http \"dir\" && sudo chmod 775 \"dir\"' ; find . -type f | xargs -I file bash -c 'sudo chown rhabbachi:http \"file\" && sudo chmod 664 \"file\"'"
function a2link() {
local site_name="$1"
if [ -e "$site_name" ]; then
  echo "Missing site name"
  return
fi
ln -sf `pwd` $HOME/public_html/$site_name
}
# PV
alias -g PV="| pv -trab |"
# Aliases
if command -v hub >/dev/null 2>&1; then
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
alias trees='tree -L 3 | less'
alias diff='colordiff'
# Needs pkgfile installed
zplug "plugins/command-not-found", from:oh-my-zsh, if:"which pkgfile"
zplug "plugins/colored-man", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
alias dog="colorize"
zplug "plugins/rsync", from:oh-my-zsh, if:"which rsync"

# Fasd
zplug "plugins/fasd", from:oh-my-zsh
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# Jumpapp
zplug "mkropat/jumpapp", as:command, of:"jumpapp"

# Git
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/gitfast", from:oh-my-zsh, if:"which git"
zplug "plugins/git-extras", from:oh-my-zsh, if:"which git"
zplug "plugins/git-flow", from:oh-my-zsh, if:"which git"
zplug "plugins/gitignore", from:oh-my-zsh, if:"which git"
zplug "github/hub", \
  as:command, \
  from:gh-r, \
  of:"*linux*amd64*"
command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"
fpath=($ZPLUG_HOME/repos/github/hub-linux-amd64-2.2.2/etc/ $fpath)
alias gsm='git show -s --format=%B'

## TLDR
zplug "pranavraja/tldr", \
  as:command, \
  from:gh-r, \
  of:"*linux*amd64*"

# Backup Home
zplug "rhabbachi/fd287c8537964e1b993b", \
  from:gist, as:command, \
  do:"chmod u+x backup-home.attic", \
  of:"backup-home.attic"

## Node.js
zplug "plugins/npm", from:oh-my-zsh

## Ruby
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/rvm", from:oh-my-zsh
#zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/knife", from:oh-my-zsh

# PHP
zplug "plugins/composer", from:oh-my-zsh

# Vagrant
zplug "plugins/vagrant", from:oh-my-zsh

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting"

zplug "plugins/history", from:oh-my-zsh
# ZSH port of Fish shell's history search feature.
zplug "plugins/history-substring-search", from:oh-my-zsh

# Desktop notification on command compleation.
zplug "plugins/bgnotify", from:oh-my-zsh
bgnotify_threshold=10 ## set your own notification threshold
function bgnotify_formatted {

[ $1 -eq 0 ] && title="$(tmux display-message -p '#S') -- Completed after $3 sec" \
  || title="$(tmux display-message -p '#S') -- Failed after $3 sec"
[ $1 -eq 0 ] && icon="dialog-ok" \
  || icon="dialog-error"

notify-send "$title"  "$2" -i "$icon";
}

# Pass password manager.
zplug "plugins/pass", from:oh-my-zsh

# A command-line fuzzy finder written in Go
# Grab binaries from GitHub Releases
# and rename to use "file:" tag
zplug "junegunn/fzf-bin", \
  as:command, \
  from:gh-r, \
  file:fzf, \
  of:"*linux*amd64*"
zplug "junegunn/fzf", as:command, of:"bin/fzf-tmux"
zplug "junegunn/fzf", of:"shell/key-bindings.zsh"

# Load systemd plugin if using systemd.
zplug "plugins/systemd", from:oh-my-zsh, if:"pidof systemd"

if grep -q "Ubuntu|Debian" /etc/lsb-release >/dev/null 2>&1; then
  zplug "plugins/debian", from:oh-my-zsh
  export apt_pref="apt-get"
  unalias ag
elif [ -f /etc/arch-release ]; then
  zplug "plugins/archlinux", from:oh-my-zsh
  command -v yaourt >/dev/null 2>&1 && alias pacman="yaourt"
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
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOSTART=true
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOQUIT=true

zplug "plugins/sublime", from:oh-my-zsh, if:"which subl3"

# Base16 Shell
zplug "chriskempson/base16-shell", of:"base16-monokai.dark.sh"

# Better prompt
zplug "bhilburn/powerlevel9k"
export DEFAULT_USER="rhabbachi"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)

# Homeshick
zplug "andsens/homeshick", of:"homeshick.sh", do:"homeshick --quiet refresh"
fpath=($ZPLUG_HOME/repos/andsens/homeshick/completions $fpath)

# Drush compleation
export DRUSH_INI="$HOME/.drush/drush.ini"
# Compleation
if ! bashcompinit >/dev/null 2>&1; then
  autoload -U bashcompinit
  bashcompinit -i
fi
zplug "$HOME/.drush/drush.complete.sh", from:local

# RVM
## Add RVM to PATH for scripting
export PATH="$HOME/.rvm/bin:$PATH"
## Load RVM into a shell session *as a function*
[[ -f "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# NVM
zplug "$HOME/.nvm/nvm.sh", from:local

# Platform.sh CLI configuration
zplug "$HOME/.composer/vendor/platformsh/cli/platform.rc", from:local

# Custom zsh config/commands
zplug "$HOME/.zplug/custom", from:local, of:"*.zsh"

# save all to init script
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

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
