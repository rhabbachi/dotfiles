# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# https://wiki.archlinux.org/index.php/Systemd/User#PATH
systemctl --user import-environment PATH

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

export EDITOR="vim"
export VISUAL=$EDITOR

# LESS
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '

setopt HIST_FIND_NO_DUPS

## Better git show alias.
alias gsm='git show -s --format=%B'

## using the vim plugin 'GV'!
## from: https://github.com/wookayin/dotfiles/blob/master/zsh/zsh.d/alias.zsh
function _vim_gv() {
  vim +"GV $1" +"autocmd BufWipeout <buffer> qall"
}
alias gv='_vim_gv'
alias gva='gv --all'

# Open file with the right application
alias o="open_command"

## RBENV
# zplug "rbenv/rbenv", as:command, use:"bin/rbenv"
# eval "$(rbenv init -)"
# zplug "rbenv/ruby-build", as:command, use:"bin/*"
# zplug "plugins/rbenv", from:oh-my-zsh, on:"rbenv/rbenv"

# Distro specific code. I have an archlinux laptop and an ubuntu server and I
# want to load different plugins and vars for each platform.
# GIT_CONTRIB is needed for git contrib scripts.
source /etc/os-release

ANTIBODY_HOME="$(antibody home)"

for plugin in ~/.zshrc.d/*.plugin(|.$ID).zsh; do
  source $plugin
done

function antibody_bundle_all () {
  antibody bundle < /home/rhabbachi/.zshrc.bundles.antibody > /home/rhabbachi/.zshrc.d/50-antibody.plugin.zsh
  antibody bundle < /home/rhabbachi/.zshrc.bundles.arch.antibody > /home/rhabbachi/.zshrc.d/50-antibody.plugin.arch.zsh
  antibody bundle < /home/rhabbachi/.zshrc.bundles.ubuntu.antibody > /home/rhabbachi/.zshrc.d/50-antibody.plugin.ubuntu.zsh
}

### PATHS ###
# Local bin dir.
export PATH="$HOME/.local/bin/:$PATH"

# Android Studio
export PATH="$HOME/Programs/android-studio/bin/:$PATH"
# Android SDK
export PATH="$HOME/Programs/Android/Sdk/tools:$PATH"
export PATH="$HOME/Programs/Android/Sdk/platform-tools:$PATH"

if [[ "$PROFILE_STARTUP" == true ]]; then
    zprof
    unsetopt xtrace
    exec 2>&3 3>&-
fi

function convert2pdf () {
  local src=$1
  local destination=$2

  i=150; convert $src -compress jpeg -quality 70 \
      -density ${i}x${i} -units PixelsPerInch \
      -resize $((i*827/100))x$((i*1169/100)) \
      -repage $((i*827/100))x$((i*1169/100)) $destination
}
