# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

function dots() {
  local MATCH
  if [[ $LBUFFER =~ '\.\.\.+' ]]; then
    LBUFFER=$LBUFFER:fs%\.\.\.%../..%
  fi
}

function dots-then-expand-or-complete() {
  zle dots
  zle expand-or-complete
}

function dots-then-accept-line() {
  zle dots
  zle accept-line
}

zle -N dots
zle -N dots-then-expand-or-complete
zle -N dots-then-accept-line

bindkey '^I' dots-then-expand-or-complete
bindkey '^M' dots-then-accept-line

alias md='mkdir -pv'
alias rd='rm -rv'
alias d='dirs -v | head -10'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'
