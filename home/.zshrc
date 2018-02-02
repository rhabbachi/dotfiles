# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
    zmodload zsh/zprof # Output load-time statistics
    # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup.$$"
    setopt xtrace prompt_subst
fi

# Persistent rehash
# Typically, compinit will not automatically find new executables in the $PATH.
# For example, after you install a new package, the files in /usr/bin would not
# be immediately or automatically included in the completion. This 'rehash' can
# be set to happen automatically.
zstyle ':completion:*' rehash true

# For Java application
# https://wiki.archlinux.org/index.php/java#Better_font_rendering
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# Disable OH-MY-ZSH updates
export DISABLE_AUTO_UPDATE="true"

# Source local defaults if missing.
[[ -z "$LANG" ]] && {
  echo "Sourcing Locale defaults"
  LANG= source /etc/profile.d/locale.sh
}

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

# Support extra escape sequences when pasting to a terminal.
# https://cirw.in/blog/bracketed-paste
zplug "plugins/safe-paste", from:oh-my-zsh

# Some useful commands for setting permissions.
zplug "plugins/perms", from:oh-my-zsh

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

## Better git show alias.
alias gsm='git show -s --format=%B'

## HUB: Load hub aliases if installed.
zplug "plugins/github", from:oh-my-zsh, if:"which hub"

## using the vim plugin 'GV'!
## from: https://github.com/wookayin/dotfiles/blob/master/zsh/zsh.d/alias.zsh
function _vim_gv() {
  vim +"GV $1" +"autocmd BufWipeout <buffer> qall"
}
alias gv='_vim_gv'
alias gva='gv --all'

# PHP
zplug "plugins/composer", from:oh-my-zsh

# Syntax highlighting bundle.
zplug "zsh-users/zsh-syntax-highlighting"

# Additional completion definitions for Zsh.
zplug "zsh-users/zsh-completions", depth:1, defer:0

# Simple plugin that auto-closes, deletes and skips over matching delimiters in
# zsh intelligently.
zplug "hlissner/zsh-autopair"

# NTFY
## We need to check if we have X running.
if command -v ntfy >/dev/null 2>&1 && xset q &>/dev/null && [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  [[ ! -z "$TMUX" ]] && export AUTO_NTFY_DONE_OPTS=(-t $(tmux display-message -p '#H:#S:#I'))
  eval "$(ntfy shell-integration)"
  ntfy -t "Ntfy Shell Integration" send "ntfy shell-integration enabled for new tty: $(tmux display-message -p '#S:#I')."
fi

# Pass password manager.
zplug "plugins/pass", from:oh-my-zsh, if:"which pass"

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
    command -v pacaur >/dev/null 2>&1 && alias pacman="PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur"
    alias pawsu="pacaur -Sy --noconfirm && pacaur -Suwr --noconfirm && PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur -Suwa --noconfirm"
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

# Node.js
zplug "plugins/npm", from:oh-my-zsh

# Manifest tool for manifest list object creation/query.
zplug "estesp/manifest-tool", \
  from:gh-r, \
  as:command

# FZF: A command-line fuzzy finder written in Go.
zplug "junegunn/fzf-bin", \
  as:command, \
  from:gh-r, \
  rename-to:"fzf"

## Helper bash script.
zplug "junegunn/fzf", \
  as:command, \
  use:"bin/fzf-tmux", \
  rename-to:"fzf-tmux", \
  at:$(fzf --version), \
  on:"junegunn/fzf-bin"

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

# A next-generation cd command with an interactive filter.
zplug "b4b4r07/enhancd", use:init.sh

# Simple delightful note taking, with none of the lock-in
export NOTES_DIRECTORY="$HOME/Notes"
zplug "pimterry/notes", \
  as:command, \
  use:"notes"

# Globalias plugin: Expands all glob expressions, subcommands and aliases
# (including global).
zplug "plugins/globalias", from:oh-my-zsh

# An oh-my-zsh plugin to help remembering those aliases you defined once
zplug "djui/alias-tips"

# Better prompt
export DEFAULT_USER="$USER"

if [ "$TERM" = "linux" ]; then
  export POWERLEVEL9K_MODE='flat'
else
  export POWERLEVEL9K_MODE='awesome-fontconfig'
fi

export ATF_BASE="/usr/share/fonts/awesome-terminal-fonts"
source $ATF_BASE"/fontawesome-regular.sh"
source $ATF_BASE"/octicons-regular.sh"

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
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs docker_machine rbenv aws pyenv)

zplug "bhilburn/powerlevel9k", at:"next", as:theme, defer:2

# Direnv: environment switcher for the shell.
eval "$(direnv hook zsh)"
## https://github.com/direnv/direnv/wiki/Tmux
alias tmux='direnv exec / tmux'

# Open file with the right application
alias o="open_command"

# Docker.
zplug "plugins/docker", from:oh-my-zsh, if:"which docker", defer:0
zplug "plugins/docker-compose", from:oh-my-zsh, if:"which docker-compose", defer:0

zplug "plugins/systemadmin", from:oh-my-zsh

# xVM
## NVM
# Disable due to poor performance.
export NVM_DIR="$ZPLUG_REPOS/creationix/nvm"
zplug "creationix/nvm", use:"nvm.sh", at:"v0.33.4"
zplug "plugins/nvm", from:oh-my-zsh, on:"creationix/nvm"

## RBENV
zplug "rbenv/rbenv", as:command, use:"bin/rbenv"
eval "$(rbenv init -)"
zplug "rbenv/ruby-build", as:command, use:"bin/*"
zplug "plugins/rbenv", from:oh-my-zsh, on:"rbenv/rbenv"

## GVM
zplug "moovweb/gvm", as:command, use:"bin/*", hook-load:"export GVM_ROOT=$ZPLUG_REPOS/moovweb/gvm"

# TaskWarror
alias taskbkmk="task add project:readitlater"

# k is the new l, yo.
zplug "supercrabtree/k"

# Base16 Shell.
zplug "chriskempson/base16-shell", hook-load:"base16_onedark"
zplug "nicodebo/base16-fzf", use:"build_scheme/base16-onedark.config", \
  on:"junegunn/fzf"

# Custom local files.
zplug "$HOME/.zshrc.d", from:local

# Save all to init script and source Then, source plugins and add commands to
# $PATH.
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
  fi
fi

zplug load

# Drush
## Drush compleation
export DRUSH_INI="$HOME/.drush/drush.ini"
# Compleation
if ! bashcompinit >/dev/null 2>&1; then
  autoload -U bashcompinit
  bashcompinit -i
fi

### PATHS ###
# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"
# Android SDK
export PATH="$HOME/Programs/Android/Sdk/tools:$PATH"
export PATH="$HOME/Programs/Android/Sdk/platform-tools:$PATH"

# https://wiki.archlinux.org/index.php/Systemd/User#PATH
systemctl --user import-environment PATH

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/rhabbachi/.zplug/repos/creationix/nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/rhabbachi/.zplug/repos/creationix/nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/rhabbachi/.zplug/repos/creationix/nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/rhabbachi/.zplug/repos/creationix/nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi
