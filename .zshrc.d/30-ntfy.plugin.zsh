# NTFY
## We need to check if we have X running.
if command -v ntfy >/dev/null 2>&1 && xset q &>/dev/null && [ "$XDG_SESSION_TYPE" = "x11" ]; then
  [[ ! -z "$TMUX" ]] && export AUTO_NTFY_DONE_OPTS=(-t $(tmux display-message -p '#H:#S:#I'))
  eval "$(ntfy shell-integration)"
  [[ ! -z "$TMUX" ]] \
    && ntfy -t "Ntfy Shell Integration" send "Notifications enabled for tmux pane $(tmux display-message -p '#S:#I')" \
    || ntfy -t "Ntfy Shell Integration" send "Notifications enabled for shell"
fi
