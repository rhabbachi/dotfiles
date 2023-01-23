# lvim envs
export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
export LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$HOME/.cache/lvim"}"

# Default to lvim.
alias vim=lvim
export EDITOR="lvim"
export VISUAL=$EDITOR

# Source local defaults if missing.
[[ -z $LANG ]] && {
  echo "Sourcing Locale defaults"
  LANG= source /etc/profile.d/locale.sh
}

### PATHS ###
# Local bin dir.
export PATH="$HOME/.local/bin:$PATH"

# Go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"
