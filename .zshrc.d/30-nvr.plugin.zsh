# Support nvr if available.

if command -v nvr >/dev/null 2>&1; then
  if [ -n "$TMUX" ]; then
    nvim_socket_dir="/run/user/${UID}/nvim"
    mkdir -p $nvim_socket_dir
    tmux_window_id=$(tmux display -p '#{window_id}')
    export NVIM_LISTEN_ADDRESS="$nvim_socket_dir/$tmux_window_id"
  fi

  nv() {
    nvr -s "$@"
  }
fi

nvd() {
  neovide --multigrid --maximized -- -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" "$@"
}
