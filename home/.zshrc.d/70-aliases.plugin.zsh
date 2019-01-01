# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
if command -v exa >/dev/null 2>&1; then
  alias ll='exa -lFb --group-directories-first --git'     #size,show type,human readable
  alias la='exa -laFb --group-directories-first --git'   #long list,show almost all,show type,human readable
  alias ldot='exa -ld .* --group-directories-first --git'
elif command -v k >/dev/null 2>&1; then
  alias ll='k -h'     #size,show type,human readable
  alias la='k -Ah'   #long list,show almost all,show type,human readable
  alias ldot='exa -Ah .*'
else
  alias ll='ls -lFh --group-directories-first'     #size,show type,human readable
  alias la='ls -lAFh'   #long list,show almost all,show type,human readable
  alias ldot='ls -ld .*'
fi

alias l=ll

alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias whereami=display_info

alias cp='cp -ivr'
alias mv='mv -iv'

alias top="htop"
alias ping='ping -c 5'
# Ping www.google.com 8 times
alias pingo="ping www.google.com -c 8"
alias date-time='date +%Y%m%d-%H%M%S'
alias clr='clear;echo "Currently logged in on $(tty), as $USER in directory $PWD."'

# Apache
alias a2log="multitail -f /var/log/httpd/localhost.error.log"

# Clear Vim tmp files
alias vim-clear="trash ~/.vimswap ~/.vimviews/ ~/.vimbackup ~/.vimundo"

# AUTOSSH
command -v autossh >/dev/null 2>&1 && alias ssh='autossh -M 0 -o "ServerAliveInterval 45" -o "ServerAliveCountMax 2"'

# PV
command -v pv >/dev/null 2>&1 && alias -g PV="| pv -trab |"

# Facebook path picker
command -v fpp >/dev/null 2>&1 && alias -g FPP="| fpp"

# Silver Searcher
if command -v ag >/dev/null 2>&1; then
  alias ag="ag -i"
  alias aphp="ag --php"
  alias fphp="ag --php -l"
  alias ajs="ag --js"
  alias fjs="ag --js -l"
  alias acss="ag --saas --css --less"
  alias fcss="ag --saas --css --less -l"

  # fe [FUZZY PATTERN] - Open the selected file with the default editor
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
  fag() {
    local file
    file=$(\ag -l $1 | \fzf --exit-0)
    [ -n "$file" ] && ${EDITOR:-vim} "$file"
  }

  # Open command in vim quickfix.
  function vimag () {
    vim -q <(ag $@) +cw
  }
fi

# Tree
command -v tree >/dev/null 2>&1 && alias trees='tree -L 3 | less'

# Diff: enable colors.
command -v diff >/dev/null 2>&1 && alias diff="diff --color=auto"

# Cat with syntaxe highlight.
command -v bat >/dev/null 2>&1 && alias cat="bat"

# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
if is-at-least 4.2.0; then
  # open browser on urls
  if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html de org net com at cx nl se dk)
    for ft in $_browser_fts; do alias -s $ft=$BROWSER; done
  fi

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts; do alias -s $ft=$EDITOR; done

  if [[ -n "$XIVIEWER" ]]; then
    _image_fts=(jpg jpeg png gif mng tiff tif xpm)
    for ft in $_image_fts; do alias -s $ft=$XIVIEWER; done
  fi

  _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
  for ft in $_media_fts; do alias -s $ft=mplayer; done

  #read documents
  alias -s pdf=acroread
  alias -s ps=gv
  alias -s dvi=xdvi
  alias -s chm=xchm
  alias -s djvu=djview

  #list whats inside packed file
  alias -s zip="unzip -l"
  alias -s rar="unrar l"
  alias -s tar="tar tf"
  alias -s tar.gz="echo "
  alias -s ace="unace l"
fi

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
