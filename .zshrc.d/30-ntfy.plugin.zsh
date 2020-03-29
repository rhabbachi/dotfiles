# NTFY
## We need to check if we have X running.
if command -v ntfy >/dev/null 2>&1 && xset q &>/dev/null && [ "$XDG_SESSION_TYPE" = "x11" ]; then
  message="Notifications enabled for shell"
  export AUTO_NTFY_DONE_IGNORE="vim vimrg screen meld git tmux man diff"

  if [ ! -z "$TMUX" ]; then
    export AUTO_NTFY_DONE_OPTS=(-t $(tmux display-message -p '#H:#S:#I'))
    message="Notifications enabled for tmux pane $(tmux display-message -p '#S:#I')"
  fi

  eval "$(ntfy shell-integration)"
fi
