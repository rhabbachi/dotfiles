set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set nofoldenable " Disable Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" Mouse
set mouse= "disable the mouse

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/<C-R>"<CR>

" https://vim.fandom.com/wiki/Search_and_replace_in_a_visual_selection#Searching_with_.2F_and_.3F
vnoremap <M-/> <Esc>/\%V

" Toggle search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

" https://github.com/mhinz/neovim-remote
" Use nvr as git editor.
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" How to delete (not cut) in Vim?
" https://stackoverflow.com/a/11993928/2047692
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
