# Default to vim.
export EDITOR="vim"
export VISUAL=$EDITOR

# Support nvr if available.
if command -v nvr >/dev/null 2>&1; then
  if [[ -n $TMUX ]]; then
    export NVIM_LISTEN_ADDRESS=/tmp/nvim_$USER_$(tmux display -p "#{window_id}")

    function nvr() {
      local pane_id=$(tmux list-panes -F '#{pane_id} #{pane_current_command}' | grep nvim | cut -f1 -d' ' | head -n1)
      if [[ $pane_id ]]; then
        tmux select-pane -t $pane_id
      fi

      /usr/bin/nvr $@
    }
  fi

  alias vicode='nvr'
fi

# Source local defaults if missing.
[[ -z $LANG ]] && {
  echo "Sourcing Locale defaults"
  LANG= source /etc/profile.d/locale.sh
}

### PATHS ###
# Local bin dir.
export PATH="$HOME/.local/bin:$PATH"
