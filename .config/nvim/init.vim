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

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()

" sensible.vim: Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode.
Plug 'kyazdani42/nvim-web-devicons', Cond(!exists('g:vscode')) |
Plug 'romgrk/barbar.nvim', Cond(!exists('g:vscode'))

Plug 'chriskempson/base16-vim', Cond(!exists('g:vscode')) |
" A light and configurable statusline/tabline plugin for Vim.
Plug 'itchyny/lightline.vim', Cond(!exists('g:vscode')) |
" Lightline.vim colorschemes for all available base16 themes
Plug 'mike-hearn/base16-vim-lightline', Cond(!exists('g:vscode'))

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot', Cond(!exists('g:vscode'))

" Tmux
" Seamless navigation between tmux panes and vim splits.
Plug 'sunaku/tmux-navigate', Cond(!exists('g:vscode'))
" Make terminal vim and tmux work better together.
" TODO seems to be depercated.
" Plug 'tmux-plugins/vim-tmux-focus-events', Cond(!exists('g:vscode'))

" sleuth.vim: Heuristically set buffer options
Plug 'tpope/vim-sleuth'

"surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Next-generation motion plugin using incremental input processing, allowing
" for unparalleled speed with minimal cognitive effort
Plug 'ggandor/lightspeed.nvim', { 'branch': 'main' }

" Vim plugin that provides additional text objects
Plug 'wellle/targets.vim'

" repeat.vim: enable repeating supported plugin maps with dot.
Plug 'tpope/vim-repeat'

" Yet another EditorConfig (http://editorconfig.org) plugin for vim written in
" vimscript only
Plug 'sgur/vim-editorconfig', Cond(!exists('g:vscode'))

" An alternative sudo.vim for Vim and Neovim, limited support sudo in Windows.
Plug 'lambdalisue/suda.vim'

" Make Vim handle line and column numbers in file names with a minimum of
" fuss.
Plug 'wsdjeg/vim-fetch', Cond(!exists('g:vscode'))

" Vim plugin which asks for the right file to open
Plug 'EinfachToll/DidYouMean', Cond(!exists('g:vscode'))

" Vim sugar for the UNIX shell commands that need it the most.
Plug 'tpope/vim-eunuch'

" vinegar.vim: Combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar', Cond(!exists('g:vscode'))

" https://github.com/asvetliakov/vscode-neovim#vim-commentary
if exists('g:vscode')
  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
else
  " commentary.vim: comment stuff out
  Plug 'tpope/vim-commentary'
endif

" Toggles between relative and absolute line numbers automatically
Plug 'myusuf3/numbers.vim', Cond(!exists('g:vscode'))

 " A Git wrapper so awesome, it should be illegal.
Plug 'tpope/vim-fugitive', Cond(!exists('g:vscode')) |
" A git commit browser in Vim.
Plug 'junegunn/gv.vim' |
" rhubarb.vim: GitHub extension for fugitive.vim
Plug 'tpope/vim-rhubarb' |
" Easy git merge conflict resolution in Vim
Plug 'christoomey/vim-conflicted'

" A Vim plugin which shows a git diff in the gutter (sign column) and
" stages/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter', Cond(!exists('g:vscode'))

" Tags
Plug 'ludovicchabant/vim-gutentags', Cond(!exists('g:vscode')) |
Plug 'liuchengxu/vista.vim', Cond(!exists('g:vscode'))

" Rainbow Parentheses.
Plug 'luochen1990/rainbow', Cond(!exists('g:vscode'))

" Vim plugin, insert or delete brackets, parens, quotes in pair
" http://www.vim.org/scripts/script.php?script_id=3599
Plug 'jiangmiao/auto-pairs'

" Auto close (X)HTML tags
Plug 'alvan/vim-closetag'

"vim-searchindex: display number of search matches & index of a current match.
Plug 'google/vim-searchindex'

" Toggle the cursor shape in the terminal for Vim.
Plug 'jszakmeister/vim-togglecursor', Cond(!exists('g:vscode'))

" abolish.vim: easily search for, substitute, and abbreviate multiple variants
" of a word
Plug 'tpope/vim-abolish'

" Plugin that adds a 'cut' operation separate from 'delete'
" Plug 'svermeulen/vim-cutlass'

" Check syntax in Vim asynchronously and fix files, with Language Server
" Protocol (LSP) support 
Plug 'dense-analysis/ale', Cond(!exists('g:vscode')) |
" ALE indicator for the lightline vim plugin
 Plug 'maximbaz/lightline-ale', Cond(!exists('g:vscode'))

" Async autocompletion for Vim 8 and Neovim with |timers|.
Plug 'prabirshrestha/asyncomplete.vim', Cond(!exists('g:vscode'))
Plug 'prabirshrestha/asyncomplete-tags.vim', Cond(!exists('g:vscode'))
Plug 'machakann/asyncomplete-ezfilter.vim', Cond(!exists('g:vscode'))

" On save, create directories if they don't exist
Plug 'dockyard/vim-easydir'

" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
Plug 'vim-vdebug/vdebug', Cond(!exists('g:vscode'))

" A Vim plugin for more pleasant editing on commit messages.
Plug 'rhysd/committia.vim', Cond(!exists('g:vscode'))

" Lightning fast left-right movement in Vim.
Plug 'unblevable/quick-scope'

" Vim plugin that shows keybindings in popup.
Plug 'liuchengxu/vim-which-key', Cond(!exists('g:vscode'))

" All the lua functions I don't want to write twice.
Plug 'nvim-lua/plenary.nvim' |
" Find, Filter, Preview, Pick. All lua, all the time.
Plug 'nvim-telescope/telescope.nvim' |
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' } |
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
