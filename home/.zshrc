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

# Needed by Eclipse
export MOZILLA_FIVE_HOME="/usr/lib/firefox"

# For Java application
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh 

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source $HOME/.rvm/scripts/rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# ChefDK
export CHEFDK_BIN="/opt/chefdk/bin"
export PATH="$CHEFDK_BIN:$PATH"

# Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
#homeshick --quiet refresh

# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"

# Go lang
export GOPATH="$HOME/.go/"
export PATH="$HOME/.go/bin/:$PATH"

# Base16 Shell
BASE16_SCHEME="monokai"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Better prompt
source $HOME/.promptline.sh

# Antigen
source $HOME/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
command-not-found
colored-man
encode64
colorize
rsync

aws

git
gitfast
git-extras
git-flow
gitignore
svn

pip

npm
node

vundle

vagrant
bundler
gem
rvm
knife

docker

composer
# Syntax highlighting bundle.
zsh-users/zsh-syntax-highlighting

# More completions
zsh-users/zsh-completions src
EOBUNDLES

antigen bundle fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

if [ $(grep "Ubuntu|Debian" /etc/lsb-release) ]; then
    antigen bundle debian
    export apt_pref="apt-get"
    unalias ag
elif [ -f /etc/arch-release ]; then
    antigen bundle archlinux
    antigen bundle systemd
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

# ZSH port of Fish shell's history search feature.
antigen bundle zsh-users/zsh-history-substring-search
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOSTART=true
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOQUIT=true
antigen bundle tmux

# Load the theme.
#antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

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

# notifyosd
[ -e .zshrc.notifyosd ] && . $HOME/.zshrc.notifyosd

# Drush
export DRUSH_INI="$HOME/.drush/drush.ini"
## Compleation
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

# Load shared shell files
# Localhost
source $HOME/.sshrc.d/common.sshrc
source $HOME/.sshrc.d/drush.sshrc
