# Default to vim.
export EDITOR="vim"
export VISUAL=$EDITOR

# Source local defaults if missing.
[[ -z $LANG ]] && {
  echo "Sourcing Locale defaults"
  LANG= source /etc/profile.d/locale.sh
}

### PATHS ###
# Local bin dir.
export PATH="$HOME/.local/bin:$PATH"

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
