## If we are inside a Tmux session open fzf in a pane.
if [[ -n $TMUX ]]; then
	export FZF_TMUX=1
	export FZF_TMUX_OPTS="-p"
fi
