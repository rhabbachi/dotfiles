# Generate static zsh plugin file from antibody bundel list.
# https://getantibody.github.io/usage/
function ,antibody_bundle_all () {
  local antibody_config="$HOME/.config/antibody"
  local dest="$HOME/.zshrc.d/50-antibody-static.plugin.zsh"

  source /etc/os-release

  # Overwrite static file from global config.
  antibody bundle < $antibody_config/bundle.antibody > $dest

  # Append host specific config to static file.
  for _file in $antibody_config/bundle.($ID|$XDG_CURRENT_DESKTOP).antibody; do
    antibody bundle < $_file >> $dest
  done
}
