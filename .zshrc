# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# https://wiki.archlinux.org/index.php/Systemd/User#PATH
systemctl --user import-environment PATH

# Persistent rehash
# Typically, compinit will not automatically find new executables in the $PATH.
# For example, after you install a new package, the files in /usr/bin would not
# be immediately or automatically included in the completion. This 'rehash' can
# be set to happen automatically.
zstyle ':completion:*' rehash true

# Distro specific code. I have an archlinux laptop and an ubuntu server and I
# want to load different plugins and vars for each platform.
source /etc/os-release

for plugin in ~/.zshrc.d/*.plugin(|.$ID|.$XDG_CURRENT_DESKTOP).zsh; do
  source $plugin
done
