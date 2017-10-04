# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# For Java application
# https://wiki.archlinux.org/index.php/java#Better_font_rendering
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# Disable OH-MY-ZSH updates
export DISABLE_AUTO_UPDATE="true"

# Source local defaults if missing.
[[ -z "$LANG" ]] && { echo "Sourcing Locale defaults"; LANG= source /etc/profile.d/locale.sh; }

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

# Load OMZ libs.
zplug "robbyrussell/oh-my-zsh", \
  use:"lib/{clipboard,compfix,completion,functions,git,grep,history,key-bindings,misc,spectrum,termsupport,theme-and-appearance}\.zsh", \
  defer:0
setopt HIST_FIND_NO_DUPS

# Clipboard integration (based off omz/lib/clipboard).
## Strip color codes and output to stdout before coping to the clipboard.
# alias clipcopy='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g" | tee /dev/tty | clipcopy'
zplug "plugins/copyfile", from:oh-my-zsh
## copy the active line from the command line buffer.
zplug "plugins/copybuffer", from:oh-my-zsh
## Copies the pathname of the current directory to clipboard.
zplug "plugins/copydir", from:oh-my-zsh

# Some useful commands for setting permissions.
zplug "plugins/perms", from:oh-my-zsh

# Additional completion definitions for Zsh.
zplug "zsh-users/zsh-completions", depth:1, defer:0

# Bundles from the default repo (robbyrussell's oh-my-zsh).
#zplug "plugins/vi-mode", from:oh-my-zsh

# Alias to reload zshrc.
zplug "plugins/zsh_reload", from:oh-my-zsh

# command-not-found Needs pkgfile installed
zplug "plugins/command-not-found", from:oh-my-zsh

# More useful nicities.
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/encode64", from:oh-my-zsh

# Rsync useful aliases.
zplug "plugins/rsync", from:oh-my-zsh, if:"which rsync"

# Jumpapp
zplug "mkropat/jumpapp", as:command, use:"jumpapp"

# Git
zplug "plugins/git", from:oh-my-zsh, if:"which git"
zplug "plugins/gitfast", from:oh-my-zsh, if:"which git"
zplug "plugins/git-extras", from:oh-my-zsh, if:"which git"
zplug "plugins/gitignore", from:oh-my-zsh, if:"which git"
zplug "Seinh/git-prune", if:"which git"
## Bettec show git alias.
alias gsm='git show -s --format=%B'
## HUB: Load hub aliases if installed.
zplug "plugins/github", from:oh-my-zsh, if:"which hub"
## using the vim plugin 'GV'!
## from: https://github.com/wookayin/dotfiles/blob/master/zsh/zsh.d/alias.zsh
function _vim_gv {
    vim +"GV $1" +"autocmd BufWipeout <buffer> qall"
}
alias gv='_vim_gv'
alias gva='gv --all'

# Backup Home
zplug "rhabbachi/fd287c8537964e1b993b", \
  from:gist, as:command, \
  hook-build:"chmod u+x backup-home.attic", \
  use:"backup-home.attic"

## Ruby
zplug "plugins/gem", from:oh-my-zsh

# PHP
zplug "plugins/composer", from:oh-my-zsh

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug "plugins/history", from:oh-my-zsh

# ZSH port of Fish shell's history search feature.
zplug "plugins/history-substring-search", from:oh-my-zsh

# NTFY
## We need to check if we have X running.
if command -v ntfy >/dev/null 2>&1 && xset q &>/dev/null && [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  [[ ! -z "$TMUX" ]] && export AUTO_NTFY_DONE_OPTS=(-o "transient" "true" -t $(tmux display-message -p '#H:#S:#I'))
  eval "$(ntfy shell-integration)"
  ntfy -t "Ntfy Shell Integration" send "ntfy shell-integration enabled for new tty: $(tmux display-message -p '#S:#I')."
fi

# Pass password manager.
zplug "plugins/pass", from:oh-my-zsh, if:"which pass"

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
    export GIT_CONTRIB="/usr/share/git"
    ;;
esac

# MOSH
zplug "plugins/mosh", from:oh-my-zsh, if:"which mosh"

# NMAP
zplug "plugins/nmap", from:oh-my-zsh, if:"which nmap"

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

# Node.js
zplug "plugins/npm", from:oh-my-zsh

# Simple jira command line client in Go
zplug "Netflix-Skunkworks/go-jira", \
  from:gh-r, \
  as:command, \
  rename-to:"jira"

function jira-summary () {
  jira view $1 -t summary
}

# Simple jira command line client in Go
zplug "estesp/manifest-tool", \
  from:gh-r, \
  as:command

# FZF: A command-line fuzzy finder written in Go.
## Helper bash script.
zplug "junegunn/fzf", \
    as:command, \
    use:"bin/fzf-tmux", \
    rename-to:"fzf-tmux", \
    at:$(fzf --version), \
    if:"command -v fzf >/dev/null 2>&1"
## If we are inside a Tmux session open fzf in a pane.
[[ ! -z "$TMUX" ]] && export FZF_TMUX=1
## Load shell files
zplug "$ZPLUG_REPOS/junegunn/fzf/shell", \
  from:local, \
  use:"*.zsh", \
  on:"junegunn/fzf"
## Extras
zplug "atweiden/fzf-extras", \
  use:"fzf-extras.zsh", \
  on:"junegunn/fzf"

# Simple delightful note taking, with none of the lock-in
export NOTES_DIRECTORY="$HOME/Notes"
zplug "pimterry/notes", \
  as:command, \
  use:"notes"

# Tools for adding grid/tiling functionality to any window manager.
zplug "jayk/window_grid", \
  as:command, \
  use:"window_grid"

# Zsh Navigation Tools
zplug "plugins/zsh-navigation-tools", from:oh-my-zsh

# Globalias plugin: Expands all glob expressions, subcommands and aliases
# (including global).
zplug "plugins/globalias", from:oh-my-zsh

# Better prompt
export DEFAULT_USER="$USER"
export POWERLEVEL9K_MODE='awesome-mapped-fontconfig'
export ATF_BASE="/usr/share/fonts/awesome-terminal-fonts"
source "$ATF_BASE/fontawesome-regular.sh"
# source "$POWERLEVEL9K_FONTAWESOME_PATH/devicons-regular.sh" # no named codepoints
source "$ATF_BASE/octicons-regular.sh"

zplug "bhilburn/powerlevel9k", at:"next", as:theme, defer:3
## OS_ICON
export POWERLEVEL9K_OS_ICON_BACKGROUND="white"
export POWERLEVEL9K_OS_ICON_FOREGROUND="black"
## Last command return code.
export POWERLEVEL9K_STATUS_OK_BACKGROUND="green"
export POWERLEVEL9K_STATUS_OK_FOREGROUND="black"
export POWERLEVEL9K_STATUS_ERROR_BACKGROUND="red"
export POWERLEVEL9K_STATUS_ERROR_FOREGROUND="black"
## Use two lines for the prompt.
export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
export POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\uf054\uf054\uf054 "
## COMMAND_EXECUTION_TIME.
export POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=15
export POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="black"
export POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="white"
## DIR
export POWERLEVEL9K_SHORTEN_DIR_LENGTH=6
## PROMPT.
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir_writable dir virtualenv nvm vcs vi_mode)
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs docker_machine rbenv aws ip ssh os_icon)

# Base16 Shell
zplug "chriskempson/base16-shell", hook-load:"base16_onedark"
zplug "nicodebo/base16-fzf", use:"build_scheme/base16-onedark.config", on:"junegunn/fzf"

# Direnv: environment switcher for the shell.
eval "$(direnv hook zsh)"
## https://github.com/direnv/direnv/wiki/Tmux
alias tmux='direnv exec / tmux'

# Custom local files.
zplug "$HOME/.zshrc.d", from:local

# Open file with the right application
function open() {
  gio open $1 &>/dev/null
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fag() {
  local file
  file=$(\ag -l $1 | \fzf --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Docker.
zplug "plugins/docker", from:oh-my-zsh, if:"which docker", defer:0
zplug "plugins/docker-compose", from:oh-my-zsh, if:"which docker-compose", defer:0

## Ahoy Docker Nucivic env.
function ahoydocker() {
  [[ $(docker-machine status) == "Stopped" ]] && docker-machine start default
  load-ahoydocker
}

function load-ahoydocker() {
  [[ $(docker-machine status) == "Running" ]] && { eval "$(docker-machine env default)"; export VIRTUAL_HOST="default.docker"; export AHOY_CMD_PROXY="DOCKER"; }
}
command -v docker-machine >/dev/null 2>&1 && load-ahoydocker

# Open command in vim quickfix.
function vimag () {
  vim -q <(ag $@) +cw
}

zplug "plugins/systemadmin", from:oh-my-zsh, defer:0

zplug "asdf-vm/asdf", use:"asdf.sh"

# save all to init script and source Then, source plugins and add commands to
# $PATH.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

alias harohome-borg-backup='BORG_RSH="ssh -i /home/rhabbachi/.ssh/localhost -p 2022" borg create -ps --exclude-caches --exclude-from ~/.attic/ignorelist borg@nextcloud.rhabbachi.net:/backups/banshee.borg::$(date +%Y%m%d-%H%M%S) /home/rhabbachi'

### PATHS ###
# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"
# Android SDK
export PATH="$HOME/Programs/Android/Sdk/tools:$PATH"
export PATH="$HOME/Programs/Android/Sdk/platform-tools:$PATH"

# https://wiki.archlinux.org/index.php/Systemd/User#PATH
systemctl --user import-environment PATH
