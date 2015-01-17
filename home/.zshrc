export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

# Enable correct colors
if [ -n "$DISPLAY" -a "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

export EDITOR="vim"
export VISUAL=$EDITOR

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

# https://wiki.archlinux.org/index.php/Sudo#Passing_aliases
alias sudo='sudo '

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
zsh_reload
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

if [ -f /etc/lsb-release ] || [ -f /etc/debian_release ] || [ -f /etc/debian_version ]; then
    antigen bundle debian
    export apt_pref="apt-get"
    unalias ag
elif [ -f /etc/arch-release ]; then
    antigen bundle archlinux
fi

# ZSH port of Fish shell's history search feature.
antigen bundle zsh-users/zsh-history-substring-search
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

[[ "$COLORTERM" == "gnome-terminal" ]] && export ZSH_TMUX_AUTOSTART=true
[[ "$COLORTERM" == "gnome-terminal" ]] && export ZSH_TMUX_AUTOQUIT=true
antigen bundle tmux

# Common aliases
antigen bundle common-aliases
alias t="multitail -f"
alias a2log="multitail -f /var/log/httpd/localhost.error.log /var/log/httpd/localhost.access.log"

# Load the theme.
#antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

export LESS='-RS#3NM~g'

# PV
alias -g PIPE="| pv -trab |"

# Drush
[[ -f ~/.zshrc.drush ]] && source $HOME/.zshrc.drush
export DRUSH_INI="$HOME/.drush/drush.ini"

if ! bashcompinit >/dev/null 2>&1; then
    autoload -U bashcompinit
    bashcompinit -i
fi
source $HOME/.drush/drush.complete.sh

# Open file with the right application
function open () {
 setsid xdg-open $1
}

# Tree
alias trees='tree -L 3 | less'

# AUTOSSH
alias ssh='autossh -M 0 -o "ServerAliveInterval 45" -o "ServerAliveCountMax 2"'

# TOP
alias top="htop"

# Ping www.google.com 32 times
alias pingo="ping www.google.com -c 8"

alias date-time='date +%Y%m%d-%H%M%S'

alias clr="clear"

# Ag
ajs() {
    ag --js "$@"
}

acss() {
    ack --saas --css --less "$@"
}

fjs() {
    ag --js -l "$@"
}

fcss() {
    ack --saas --css --less -l "$@"
}
