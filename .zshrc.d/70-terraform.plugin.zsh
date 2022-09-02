# https://github.com/superblk/terve#setup
export PATH="$HOME/.terve/bin:$PATH"

terraform-targets() {
  sed 's/\x1b\[[0-9;]*m//g' | grep -o '# [^( ]* ' | grep '\.' | sed " s/^# /-target '/; s/ $/'/; "
}
