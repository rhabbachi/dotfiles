export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

# Enable correct colors
if [ -n "$DISPLAY" -a "$TERM" = "xterm" ]; then
  export TERM=xterm-256color
fi

### PATHS ###
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ]; then
  export PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"

# Go lang
export GOPATH="$HOME/.go/"
export PATH="$HOME/.go/bin/:$PATH"

# ChefDK
#export CHEFDK_BIN="/opt/chefdk/bin"
#export PATH="$CHEFDK_BIN:$PATH"

# Needed by Eclipse
export MOZILLA_FIVE_HOME="/usr/lib/firefox"

# For Java application
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh 

# RVM
## Add RVM to PATH for scripting
export PATH="$HOME/.rvm/bin:$PATH"
## Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
#homeshick --quiet refresh

# Base16 Shell
BASE16_SCHEME="default"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# TMUX plugin
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOSTART=true
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOQUIT=true

# bgnotify
bgnotify_threshold=10 ## set your own notification threshold

function bgnotify_formatted {
## $1=exit_status, $2=command, $3=elapsed_time

[ $1 -eq 0 ] && title="$(tmux display-message -p '#S') -- Completed after $3 sec" || title="$(tmux display-message -p '#S') -- Failed after $3 sec"
[ $1 -eq 0 ] && icon="dialog-ok" || icon="dialog-error"

notify-send "$title"  "$2" -i "$icon";
}

# zgen
source $HOME/.zgen/zgen.zsh
# check if there's no init script
if ! zgen saved; then
  echo "Creating a zgen save"

  export DISABLE_AUTO_UPDATE="true"
  # Load the oh-my-zsh's library.
  zgen oh-my-zsh

  # Bundles from the default repo (robbyrussell's oh-my-zsh).
  ## Core
  # Needs pkgfile installed
  zgen oh-my-zsh plugins/command-not-found 
  zgen oh-my-zsh plugins/colored-man
  zgen oh-my-zsh plugins/encode64
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/rsync
  #zgen oh-my-zsh plugins/vi-mode
  zgen oh-my-zsh plugins/fasd

  #aws

  ## Version Controle Systems
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/gitfast
  zgen oh-my-zsh plugins/git-extras
  zgen oh-my-zsh plugins/git-flow
  zgen oh-my-zsh plugins/gitignore
  #svn

  ## Python
  zgen oh-my-zsh plugins/pip

  ## Node.js
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/node

  ## Ruby
  zgen oh-my-zsh plugins/gem
  zgen oh-my-zsh plugins/rvm
  zgen oh-my-zsh plugins/bundler
  zgen oh-my-zsh plugins/knife

  # PHP
  zgen oh-my-zsh plugins/composer

  zgen oh-my-zsh plugins/vagrant

  # Syntax highlighting bundle.
  zgen load zsh-users/zsh-syntax-highlighting

  zgen oh-my-zsh plugins/history
  # ZSH port of Fish shell's history search feature.
  zgen oh-my-zsh plugins/history-substring-search
  zgen oh-my-zsh plugins/bgnotify
  # More completions
  #zsh-users/zsh-completions src

  zgen oh-my-zsh plugins/fasd
  alias a='fasd -a'        # any
  alias s='fasd -si'       # show / search / select
  alias d='fasd -d'        # directory
  alias f='fasd -f'        # file
  alias sd='fasd -sid'     # interactive directory selection
  alias sf='fasd -sif'     # interactive file selection
  alias z='fasd_cd -d'     # cd, same functionality as j in autojump
  alias zz='fasd_cd -d -i' # cd with interactive selection

  if [ $(grep "Ubuntu|Debian" /etc/lsb-release) ]; then
    zgen oh-my-zsh plugins/debian
    export apt_pref="apt-get"
    unalias ag
  elif [ -f /etc/arch-release ]; then
    zgen oh-my-zsh plugins/archlinux
    zgen oh-my-zsh plugins/systemd
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

  zgen oh-my-zsh plugins/tmux

  zgen oh-my-zsh sublime
  # theme
  zgen load bhilburn/powerlevel9k

  # save all to init script
  zgen save

fi

# Enable search by globs
# http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# Better prompt
export DEFAULT_USER="rhabbachi"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
source $HOME/.zgen/bhilburn/powerlevel9k-master/powerlevel9k.zsh-theme

## ZSH specific aliases (Global etc)
alias zshrc='vim ~/.zshrc' # Quick access to the ~/.zshrc file

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"
# PV
alias -g PV="| pv -trab |"

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

# reload zshrc
function src()
{
  local current_pwd=`pwd`
  cd ~
  local cache="$ZSH/cache"
  autoload -U compinit zrecompile
  compinit -d "$cache/zcomp-$HOST"

  for f in ~/.zshrc "$cache/zcomp-$HOST"; do
    zrecompile -p $f && command rm -f $f.zwc.old
  done

  source ~/.zshrc

  cd $current_pwd
}

## Drush
export DRUSH_INI="$HOME/.drush/drush.ini"
# Compleation
if ! bashcompinit >/dev/null 2>&1; then
  autoload -U bashcompinit
  bashcompinit -i
fi
source $HOME/.drush/drush.complete.sh

# Open file with the right application
function open () {
setsid xdg-open $1
}

# AUTOSSH
alias ssh='autossh -M 0 -o "ServerAliveInterval 45" -o "ServerAliveCountMax 2"'

# Platform.sh CLI configuration
PLATFORMSH_CONF=~/.composer/vendor/platformsh/cli/platform.rc
[ -f "$PLATFORMSH_CONF" ] && . "$PLATFORMSH_CONF"

# Editor
export EDITOR="vim"
export VISUAL=$EDITOR

# GIT
alias gsm='git show -s --format=%B'
command -v hub >/dev/null 2>&1 && alias git=hub

# Load shared shell files
# Localhost
source $HOME/.zshrc.common
source $HOME/.zshrc.drush

