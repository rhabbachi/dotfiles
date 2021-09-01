" vim:tw=78:ts=2:sts=2:sw=2:ft=vim:norl:
" To use pacman-installed vim addons with neovim, enable the default vim runtime
" path by adding the following line to your neovim configuration:

set runtimepath^=/usr/share/vim/vimfiles

let mapleader = "\<Space>"

" Highlight current line
set cursorline
" SignColumn should match background
" highlight clear SignColumn
" Current line number row will have same background color in relative mode
" highlight clear LineNr
" Remove highlight color from current line number
"highlight clear CursorLineNr

" Use GUI colors for the terminal
set termguicolors

""
"Splits
""
" Puts new vsplit windows to the right of the current
set splitright
" Puts new split windows to the bottom of the current
set splitbelow

" System clipboard.
if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" netrw {
let g:netrw_home= expand('~/.cache/nvim/netrw')
let g:netrw_liststyle=3
let g:netrw_browse_split = 0
"}
"
call plug#begin()

" sensible.vim: Defaults everyone can agree on
Plug 'tpope/vim-sensible'

Plug 'chriskempson/base16-vim' |
" A light and configurable statusline/tabline plugin for Vim.
Plug 'itchyny/lightline.vim' |
" Lightline.vim colorschemes for all available base16 themes
Plug 'mike-hearn/base16-vim-lightline'

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" Tmux
" Seamless navigation between tmux panes and vim splits.
Plug 'christoomey/vim-tmux-navigator'
" Make terminal vim and tmux work better together.
Plug 'tmux-plugins/vim-tmux-focus-events'

" sleuth.vim: Heuristically set buffer options
Plug 'tpope/vim-sleuth'

"surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'

" repeat.vim: enable repeating supported plugin maps with dot.
Plug 'tpope/vim-repeat'

" Yet another EditorConfig (http://editorconfig.org) plugin for vim written in
" vimscript only
Plug 'sgur/vim-editorconfig'

" An alternative sudo.vim for Vim and Neovim, limited support sudo in Windows.
Plug 'lambdalisue/suda.vim'

" Helpers for UNIX
Plug 'tpope/vim-eunuch'

" vinegar.vim: Combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'

" Toggles between relative and absolute line numbers automatically
Plug 'myusuf3/numbers.vim'

 " A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive' |
" A git commit browser in Vim 
Plug 'junegunn/gv.vim' |
" rhubarb.vim: GitHub extension for fugitive.vim
Plug 'tpope/vim-rhubarb' |
" Easy git merge conflict resolution in Vim
Plug 'christoomey/vim-conflicted'

" A Vim plugin which shows a git diff in the gutter (sign column) and
" stages/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'
 
" Make Vim handle line and column numbers in file names with a minimum of
" fuss.
Plug 'wsdjeg/vim-fetch'

" Tags
Plug 'ludovicchabant/vim-gutentags' |
Plug 'liuchengxu/vista.vim'

" Rainbow Parentheses
Plug 'luochen1990/rainbow'

" Vim plugin, insert or delete brackets, parens, quotes in pair
" http://www.vim.org/scripts/script.php?script_id=3599
Plug 'jiangmiao/auto-pairs'

" Auto close (X)HTML tags
Plug 'alvan/vim-closetag'

"vim-searchindex: display number of search matches & index of a current match.
Plug 'google/vim-searchindex'

" Toggle the cursor shape in the terminal for Vim.
Plug 'jszakmeister/vim-togglecursor'

" abolish.vim: easily search for, substitute, and abbreviate multiple variants
" of a word
Plug 'tpope/vim-abolish'

" Vim plugin which asks for the right file to open
Plug 'EinfachToll/DidYouMean'

" Plugin that adds a 'cut' operation separate from 'delete'
" Plug 'svermeulen/vim-cutlass'

" Check syntax in Vim asynchronously and fix files, with Language Server
" Protocol (LSP) support 
Plug 'dense-analysis/ale' |
" ALE indicator for the lightline vim plugin
 Plug 'maximbaz/lightline-ale'

" Async autocompletion for Vim 8 and Neovim with |timers|.
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-tags.vim'
Plug 'machakann/asyncomplete-ezfilter.vim'

" fzf heart vim
Plug 'junegunn/fzf.vim' |
" Improve the project search experience when using tools like ag and rg.
 Plug 'jesseleite/vim-agriculture'

" On save, create directories if they don't exist
Plug 'dockyard/vim-easydir'

" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
Plug 'vim-vdebug/vdebug'

Plug 'rhysd/committia.vim'

" Lightning fast left-right movement in Vim 
Plug 'unblevable/quick-scope'

" Vim plugin that shows keybindings in popup.
Plug 'liuchengxu/vim-which-key'
call plug#end()
