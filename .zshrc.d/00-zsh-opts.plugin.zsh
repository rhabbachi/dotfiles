
## History
# Source https://leetschau.github.io/remove-duplicate-zsh-history.html

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found,  even  if the duplicates are not
# contiguous.
setopt HIST_FIND_NO_DUPS

# If  a  new command line being added to the history list duplicates an older
#   one, the older command is removed from the list (even if it is not the
#   previous event).
setopt HIST_IGNORE_ALL_DUPS

# When writing out the history file, older commands that duplicate newer ones
# are omitted.
setopt HIST_SAVE_NO_DUPS

# Beep in ZLE when a widget attempts to access a history entry which isn't
# there.
setopt HIST_BEEP
