function ,yarmorph() {
  orphaned=$(yay -Qtdq)

  if [[ -n $orphaned ]]; then
    # Make sure to strip any new lines from the input.
    yay -Rs $(printf "%s" $orphaned)
  fi
}

if command -v yay >/dev/null 2>&1; then
  cmd_aur="yay -Syu --noconfirm --aur --devel --answerupgrade Repo --answerclean None --answerdiff None"

  if command -v pacman-offline >/dev/null 2>&1; then
    cmd_repo="sudo pacman-offline -y"
  else
    cmd_repo="yay -Syuw --repo --answerupgrade None --noconfirm"
  fi

  alias ,upgrade=",yarmorph; $cmd_aur; $cmd_repo; sudo paccache -rvk2"
fi

# GIT_CONTRIB is needed for git contrib scripts.
export GIT_CONTRIB="/usr/share/git"
