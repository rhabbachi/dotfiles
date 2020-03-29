# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
if command -v exa >/dev/null 2>&1; then

  #
  # Project:  zsh-aliases-exa
  # File:     /zsh-aliases-exa.plugin.zsh
  # Created:  2019-04-12 19:07:28
  # Author:   Darrin Tisdale
  # -----
  # Modified: 2019-05-14 23:18:24
  # Editor:   Darrin Tisdale
  #

  # general use
  alias ls='exa'                                                        # ls
  alias l='exa -lbF --git'                                              # list, size, type, git
  alias ll='exa -lbGF --git'                                            # long list
  alias llm='exa -lbGF --git --sort=modified'                           # long list, modified date sort
  alias la='exa -lbhHigmuSa --time-style=long-iso --git --color-scale'  # all list
  alias lx='exa -lbhHigmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

  # speciality views
  alias lS='exa -1' # one column, just names
  alias lt='exa --tree --level=2'
elif command -v k >/dev/null 2>&1; then
  alias ll='k -h'  #size,show type,human readable
  alias la='k -Ah' #long list,show almost all,show type,human readable
  alias ldot='k -Ah .*'
else
  alias ll='ls -lFh --group-directories-first' #size,show type,human readable
  alias la='ls -lAFh'                          #long list,show almost all,show type,human readable
  alias ldot='ls -ld .*'
fi

alias zshrc='$EDITOR ~/.zshrc'                # Quick access to the ~/.zshrc file
alias tmuxrc='$EDITOR ~/.tmux.conf'           # Quick access to the ~/.tmux.conf file
alias vimrc='$EDITOR ~/.config/nvim/init.vim' # Quick access to the ~/.vimrc file

# Grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

# Git
## Better git show alias.
alias gsm='git show -s --format=%B'

## using the vim plugin 'GV'!
## from: https://github.com/wookayin/dotfiles/blob/master/zsh/zsh.d/alias.zsh
function _vim_gv() {
  vim +"GV $1" +"autocmd BufWipeout <buffer> qall"
}
alias gv='_vim_gv'
alias gva='gv --all'

# Open file with the right application
alias o="open_command"

# Tail
alias t='tail -f'

# LESS
if command -v src-hilite-lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
  export LESS=' -R '
fi

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep -i'
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
command -v autossh >/dev/null 2>&1 && alias ssh='TERM="xterm-256color" autossh -M 0'

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
  function vimag() {
    vim -q <(ag $@) +cw
  }
fi

# RIP Grep
if command -v rg >/dev/null 2>&1; then
  alias rg="rg -i"
  alias rgphp="rg -t 'php'"
  alias fphp="rgphp -l"
  alias rgjs="rg -t 'js'"
  alias fjs="rgjs -l"
  alias rgcss="rg -t 'saas' -t 'css' -t 'less'"
  alias fcss="rgcss -l"
  alias rgyaml="rg -t 'yaml'"
  alias fyaml="rgyaml -l"

  # fe [FUZZY PATTERN] - Open the selected file with the default editor
  #   - Bypass fuzzy finder if there's only one match (--select-1)
  #   - Exit if there's no match (--exit-0)
  frg() {
    local file
    file=$(\rg -l $1 | \fzf --exit-0)
    [ -n "$file" ] && ${EDITOR:-vim} "$file"
  }

  # Open command in vim quickfix.
  function vimrg() {
    vim -q <(rg --vimgrep $@) +cw
  }
fi

# Tree
command -v tree >/dev/null 2>&1 && alias trees='tree -L 3 | less'

# Diff: enable colors, recursive..
command -v diff >/dev/null 2>&1 && alias diff="diff -r --color=auto"

# Cat with syntaxe highlight.
command -v bat >/dev/null 2>&1 && alias cat="bat"

# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
if is-at-least 4.2.0; then
  # open browser on urls
  if [[ -n $BROWSER ]]; then
    _browser_fts=(htm html de org net com at cx nl se dk)
    for ft in $_browser_fts; do alias -s $ft=$BROWSER; done
  fi

  _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
  for ft in $_editor_fts; do alias -s $ft=$EDITOR; done

  if [[ -n $XIVIEWER ]]; then
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

# Misc helper functions.

function convert2pdf() {
  local src=$1
  local destination=$2

  i=150
  convert $src -compress jpeg -quality 70 \
    -density ${i}x${i} -units PixelsPerInch \
    -resize $((i * 827 / 100))x$((i * 1169 / 100)) \
    -repage $((i * 827 / 100))x$((i * 1169 / 100)) $destination
}

# PDF conversion using unoconv.
if command -v unoconv >/dev/null 2>&1; then
  function unoconv2pdf() {
    local src=$1
    local destination=$2

    unoconv -f pdf -o $destination $src
  }

  function pnm2pdf() {
    for source in $(find . -name "*.pnm"); do
      unoconv -v -f pdf -o ${source/%pnm/pdf} $source &&
        trash $source
    done
  }
fi

# Zoom a pane.
if [ ! -z "$TMUX" ]; then
  function peek() {
    tmux split-window -p 33 "$EDITOR" "$@"
  }
fi
