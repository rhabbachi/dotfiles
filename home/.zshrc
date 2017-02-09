# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# For Java application
# https://wiki.archlinux.org/index.php/java#Better_font_rendering
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# Disable OH-MY-ZSH updates
export DISABLE_AUTO_UPDATE="true"

# Misc
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"
export EDITOR="vim"
export VISUAL=$EDITOR

# LESS
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '

# Check if zplug is installed
[[ -f $HOME/.zplug/init.zsh ]] || {
  echo "Installing zplug"
  curl -sL zplug.sh/installer | zsh
  source ~/.zplug/init.zsh && zplug update --self
}

zstyle ":zplug:tag" defer 2

source ~/.zplug/init.zsh

zplug "robbyrussell/oh-my-zsh", \
  use:"lib/{clipboard,compfix,completion,functions,git,grep,history,key-bindings,misc,spectrum,termsupport,theme-and-appearance}\.zsh", \
  defer:0
setopt HIST_FIND_NO_DUPS

alias clipcopy='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g" | tee /dev/tty | clipcopy'

#Additional completion definitions for Zsh.
zplug "zsh-users/zsh-completions", depth:1, defer:0

# Bundles from the default repo (robbyrussell's oh-my-zsh).
#zplug "plugins/vi-mode", from:oh-my-zsh

# Core

zplug "plugins/vundle", from:oh-my-zsh

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

# command-not-found Needs pkgfile installed
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh
zplug "plugins/rsync", from:oh-my-zsh, if:"which rsync"

# Jumpapp
zplug "mkropat/jumpapp", as:command, use:"jumpapp"

# Git
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/gitfast", from:oh-my-zsh, if:"which git"
zplug "plugins/git-extras", from:oh-my-zsh, if:"which git"
zplug "plugins/gitignore", from:oh-my-zsh, if:"which git"
zplug "Seinh/git-prune", if:"which git"

# HUB
command -v hub >/dev/null 2>&1 && eval "$(hub alias -s)"

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

# Distro specific code. I have an archlinux laptop and an ubuntu server and I
# want to load different plugins and vars for each platform.
# GIT_CONTRIB is needed for git contrib scripts.
source /etc/os-release

case "$ID" in
  ubuntu*)
    # Unalias ag since it's our search app.
    zplug "plugins/debian", from:oh-my-zsh, hook-load:"unalias ag"
    export apt_pref="apt-get"
    export GIT_CONTRIB="/usr/share/doc/git/contrib"
    ;;
  arch*)
    zplug "plugins/archlinux", from:oh-my-zsh
    command -v pacaur >/dev/null 2>&1 && alias pacman="pacaur"
    # https://wiki.archlinux.org/index.php/Pacman_tips
    # '[r]emove [o]rphans' - recursively remove ALL orphaned packages
    alias pacman-remove-orphans="/usr/bin/pacman -Qtdq > /dev/null && sudo /usr/bin/pacman -Rns \$(/usr/bin/pacman -Qtdq | sed -e ':a;N;\$!ba;s/\n/ /g')"
    export GIT_CONTRIB="/usr/share/git"
    ;;
esac

# MOSH
zplug "plugins/mosh", from:oh-my-zsh, if:"which mosh"

# NMAP
zplug "plugins/nmap", from:oh-my-zsh, if:"which nmap"

# JSON
zplug "plugins/jsontools", from:oh-my-zsh

# TMUX plugin
zplug "plugins/tmux", from:oh-my-zsh, if:"which tmux"
[[ "$DESKTOP_SESSION" == "gnome" ]] && export ZSH_TMUX_AUTOQUIT=true

# Homeshick
zplug "andsens/homeshick", use:"homeshick.sh", defer:0
## Load the completions
zplug "andsens/homeshick", use:"completions", defer:0

# Drush compleation
export DRUSH_INI="$HOME/.drush/drush.ini"
# Compleation
if ! bashcompinit >/dev/null 2>&1; then
  autoload -U bashcompinit
  bashcompinit -i
fi

# NVM
## Set NVM_DIR if it isn't already defined
[[ -z "$NVM_DIR" ]] && export NVM_DIR="$HOME/.nvm"
## Load nvm if it exists
[[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
## place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
command -v nvm >/dev/null 2>&1 && { add-zsh-hook chpwd load-nvmrc; load-nvmrc; }

# Simple jira command line client in Go
zplug "Netflix-Skunkworks/go-jira", \
  from:gh-r, \
  as:command, \
  rename-to:"jira"

# A command-line fuzzy finder written in Go.
## Helper bash script.
zplug "junegunn/fzf", \
    as:command, \
    use:"bin/fzf-tmux", \
    rename-to:"fzf-tmux"

# Simple delightful note taking, with none of the lock-in
zplug "pimterry/notes", \
  as:command, \
  use:"notes"
export NOTES_DIRECTORY="$HOME/Notes"

# Better prompt
export DEFAULT_USER="$USER"
export POWERLEVEL9K_MODE='awesome-fontconfig'
zplug "bhilburn/powerlevel9k", as:theme, defer:3
## OS_ICON
export POWERLEVEL9K_OS_ICON_BACKGROUND="white"
export POWERLEVEL9K_OS_ICON_FOREGROUND="black"
## STATUS
export POWERLEVEL9K_STATUS_OK_BACKGROUND="green"
export POWERLEVEL9K_STATUS_OK_FOREGROUND="black"
export POWERLEVEL9K_STATUS_ERROR_BACKGROUND="red"
export POWERLEVEL9K_STATUS_ERROR_FOREGROUND="black"
## Misc
export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
export POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="\uf054 "
## PROMPT
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv nvm vcs vi_mode root_indicator)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs docker_machine rbenv aws ip time os_icon)

# Base16 Shell
zplug "chriskempson/base16-shell", use:"scripts/base16-monokai.sh", defer:3
BASE16_SHELL="$HOME/.zplug/repos/chriskempson/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Direnv: environment switcher for the shell.
eval "$(direnv hook zsh)"
## https://github.com/direnv/direnv/wiki/Tmux
alias tmux='direnv exec / tmux'

# Custom local files.
zplug "$HOME/.zshrc.d", from:local

# Open file with the right application
function open () {
  setsid xdg-open $1
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fag() {
  local file
  file=$(\ag -l $1 | \fzf --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Docker
zplug "plugins/docker", from:oh-my-zsh, if:"which docker", defer:0
zplug "plugins/docker-compose", from:oh-my-zsh, if:"which docker-compose", defer:0

## Ahoy Docker Nucivic env
function ahoydocker() {
  [[ $(docker-machine status) == "Stopped" ]] && docker-machine start default
  load-ahoydocker
}

function load-ahoydocker() {
  [[ $(docker-machine status) == "Running" ]] && { eval "$(docker-machine env default)"; export VIRTUAL_HOST="default.docker"; export AHOY_CMD_PROXY="DOCKER"; }
}
command -v docker-machine >/dev/null 2>&1 && load-ahoydocker

function tmux-project() {
  name=${1-$(basename $(pwd))}

  if [[ $(tmux ls -F '#S') =~ "$name" ]]; then
    if [ -n "$TMUX" ]; then
      tmux attach -t "$name"
    else
      tmux switch-client -t "$name"
    fi
  else
    tmux new -ds "$name" && tmux switch-client -t "$name"
  fi
}

function currentworkspace() {
  echo $(wmctrl -d | gawk '{if ($2 == "*") print tolower($10)"_"($11)}')
}

# Open command in vim quickfix
function vimag () {
  vim -q <(ag $@) +cw
}

# save all to init script and source Then, source plugins and add commands to
# $PATH.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

### PATHS ###
# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"
# Android SDK
export PATH="$HOME/Programs/Android/Sdk/tools:$PATH"
export PATH="$HOME/Programs/Android/Sdk/platform-tools:$PATH"

# Go lang
export GOPATH="$HOME/.go/"
export PATH="$HOME/.go/bin/:$PATH"

# RVM
## Add RVM to PATH for scripting
export PATH="$HOME/.rvm/bin:$PATH"
## Load RVM into a shell session *as a function*
[[ -f "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# https://wiki.archlinux.org/index.php/Systemd/User#PATH
systemctl --user import-environment PATH
