# Enable correct colors
[[ "$COLORTERM" == "gnome-terminal" ]] && export TERM=xterm-256color

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

antigen bundle debian
export apt_pref="apt-get"
unalias ag

[[ "$COLORTERM" == "gnome-terminal" ]] && export ZSH_TMUX_AUTOSTART=true
[[ "$COLORTERM" == "gnome-terminal" ]] && export ZSH_TMUX_AUTOQUIT=true
antigen bundle tmux

# Common aliases
antigen bundle common-aliases
alias t="multitail -f"
alias a2log="multitail -f /var/log/apache2/localhost.error.log /var/log/apache2/localhost.access.log"

# Tell antigen that you're done.
antigen apply

# PV
alias -g PV="| pv -ptrab |"

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

# Homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

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
