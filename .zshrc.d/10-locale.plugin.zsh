# Source local defaults if missing.
[[ -z "$LANG" ]] && {
  echo "Sourcing Locale defaults"
  LANG= source /etc/profile.d/locale.sh
}
