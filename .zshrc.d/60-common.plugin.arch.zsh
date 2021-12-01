if command -v pacaur >/dev/null 2>&1; then
  # alias pacman="PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur"
  # alias pawsu="pacaur -Sy --noconfirm && pacaur -Suwr --noconfirm && PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur -Suwa --noconfirm"
fi

function ,yayrmorphans () {
  orphned=$(yay -Qtdq)

  if [[ ! -z $orphned ]]; then
    yay -Rs $orphned
  fi
}

if command -v yay >/dev/null 2>&1; then
  cmd_aur="yay -Syu --noconfirm --aur --devel --answerupgrade Repo --answerclean None --answerdiff None"

  if command -v pacman-offline >/dev/null 2>&1; then
    cmd_repo="sudo pacman-offline -y"
  else
    cmd_repo="yay -Syuw --repo --answerupgrade None --noconfirm"
  fi

  alias ,yuaywr="$cmd_aur; $cmd_repo; sudo paccache -rvk2; ,yayrmorphans"
fi

# GIT_CONTRIB is needed for git contrib scripts.
export GIT_CONTRIB="/usr/share/git"