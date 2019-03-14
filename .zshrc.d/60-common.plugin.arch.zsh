command -v pacaur >/dev/null 2>&1 \
    && alias pacman="PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur"
    alias pawsu="pacaur -Sy --noconfirm && pacaur -Suwr --noconfirm && PKGDEST=\"/home/rhabbachi/.local/cache/pacman/pkg/\" pacaur -Suwa --noconfirm"
    export GIT_CONTRIB="/usr/share/git"
