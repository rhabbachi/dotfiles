# Direnv: environment switcher for the shell.
eval "$(direnv hook zsh)"
## https://github.com/direnv/direnv/wiki/Tmux
[[ ! -z "$TMUX" ]] && alias tmux='direnv exec / tmux'
