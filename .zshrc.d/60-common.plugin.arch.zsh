if command -v pacaur >/dev/null 2>&1; then
  # alias pacman="PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur"
  # alias pawsu="pacaur -Sy --noconfirm && pacaur -Suwr --noconfirm && PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur -Suwa --noconfirm"
fi

if command -v yay >/dev/null 2>&1; then
  alias ,yuaywr="yay -Syu --noconfirm --aur --devel --answerupgrade Repo --answerclean None --answerdiff None && yay -Syuw --repo --answerupgrade None --noconfirm"
fi

# GIT_CONTRIB is needed for git contrib scripts.
export GIT_CONTRIB="/usr/share/git"
