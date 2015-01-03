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

# GTK2/3 SETTINGS
#export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
#export GTK3_RC_FILES="$HOME/.gtkrc-3.0"

### App Options ###
# For Java application
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export _JAVA_FONTS="/usr/share/fonts/TTF"

# NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh 

# RVM
source $HOME/.rvm/scripts/rvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# ChefDK
export CHEFDK_BIN="/opt/chefdk/bin"
export PATH="$CHEFDK_BIN:$PATH"
