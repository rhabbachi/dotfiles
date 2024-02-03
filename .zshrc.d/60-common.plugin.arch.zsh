function ,yarmorph() {
	if ! command -v yay >/dev/null 2>&1; then
		echo "yay command not available."
		return
	fi

	orphaned=$(yay -Qtdq)

	if [[ -n $orphaned ]]; then
		# Make sure to strip any new lines from the input.
		yay -Rs $(printf "%s" $orphaned)
	fi
}

function ,upgrade() {
	if ! command -v yay >/dev/null 2>&1; then
		echo "yay command not available."
		return
	fi

	# Remove orphaned.
	,yarmorph

	# Package upgrade.
	yay -Syu --noconfirm --aur --devel --answerupgrade Repo --answerclean None --answerdiff None

	if command -v pacman-offline >/dev/null 2>&1; then
		sudo pacman-offline -y
	else
		yay -Syuw --repo --answerupgrade None --noconfirm
	fi

	# Firmware upgrade.
	fwupdmgr refresh
	fwupdmgr update
}
