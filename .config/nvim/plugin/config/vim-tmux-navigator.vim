if has_key(g:plugs, 'vim-tmux-navigator')
  noremap <silent> <m-h> :TmuxNavigateLeft<cr>
  noremap <silent> <m-j> :TmuxNavigateDown<cr>
  noremap <silent> <m-k> :TmuxNavigateUp<cr>
  noremap <silent> <m-l> :TmuxNavigateRight<cr>
endif
