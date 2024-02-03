# OMZ needs this set to the correct path.
source '/usr/share/zsh-antidote/antidote.zsh'
export ZSH="$(antidote home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

# Disable OH-MY-ZSH updates
export DISABLE_AUTO_UPDATE="true"

# Generate static zsh plugin file from antidote bundle list.
# https://getantidote.github.io/usage/
function ,antidote_bundle_all () {
  local BUNDLES_DIR="$HOME/.config/antidote"
  local ZSHRCD="$HOME/.zshrc.d/"

  source /etc/os-release

  # Overwrite static file from global config.
  antidote bundle < $BUNDLES_DIR/bundle.txt > "$ZSHRCD/50-bundle.plugin.zsh"

  # Append host specific config to static file.
  for _file in $BUNDLES_DIR/bundle.($ID|$XDG_CURRENT_DESKTOP).txt; do
    basename=${_file##*/}
    antidote bundle < $_file > "$ZSHRCD/50-${basename%.txt}.plugin.zsh"
  done
}
