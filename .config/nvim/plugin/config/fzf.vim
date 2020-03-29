if has_key(g:plugs, 'fzf.vim')

  let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit'
        \ }

  nmap <Leader>f :GFiles<CR>
  nmap <Leader>F :Files<CR>
  nmap <Leader>t :BTags<CR>
  nmap <Leader>T :Tags<CR>
  " nmap <Leader>m :Methods<CR>
  nmap <Leader>b :Buffers<CR>
  nmap <Leader>l :BLines<CR>
  nmap <Leader>L :Lines<CR>
  nmap <Leader>h :History<CR>
  " nmap <Leader>H :GHistory<CR>
  nmap <Leader>: :History:<CR>
  nmap <Leader>M :Maps<CR>
  nmap <Leader>C :Commands<CR>
  nmap <Leader>' :Marks<CR>
  nmap <Leader>s :Filetypes<CR>
  nmap <Leader>S :Snippets<CR>
  nmap <Leader><Leader>h :Helptags!<CR>

  augroup fzf
    autocmd!
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
          \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  augroup END

endif
