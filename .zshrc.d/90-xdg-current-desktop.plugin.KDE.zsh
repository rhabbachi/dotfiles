# set ELECTRON_TRASH env var.
if command -v kioclient5 >/dev/null 2>&1; then
  export ELECTRON_TRASH="kioclient5"
elif command -v kioclient >/dev/null 2>&1; then
  export ELECTRON_TRASH="kioclient"
elif command -v trash-cli >/dev/null 2>&1; then
  export ELECTRON_TRASH="trash-cli"
fi

if command -v ksshaskpass >/dev/null 2>&1; then
  export SUDO_ASKPASS=$(which ksshaskpass)
fi
