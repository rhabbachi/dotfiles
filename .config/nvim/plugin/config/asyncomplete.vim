
if has_key(g:plugs, 'asyncomplete.vim')
  let g:asyncomplete_auto_popup = 0

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ asyncomplete#force_refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  "
  inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

  imap <c-space> <Plug>(asyncomplete_force_refresh)

  if has_key(g:plugs, 'ale')
    " Use ALE's function for asyncomplete defaults
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
          \ 'priority': 20,
          \ }))
  endif

  if has_key(g:plugs, 'vim-gutentags')
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
          \ 'name': 'tags',
          \ 'priority': 10,
          \ 'whitelist': ['c'],
          \ 'completor': function('asyncomplete#sources#tags#completor'),
          \ 'config': {
          \    'max_file_size': 50000000,
          \  },
          \ }))
  endif

  " Implements a priority sort function.
  function! s:sort_by_priority_preprocessor(options, matches) abort
    let l:items = []
    for [l:source_name, l:matches] in items(a:matches)
      for l:item in l:matches['items']
        if stridx(l:item['word'], a:options['base']) == 0
          let l:item['priority'] =
                \ get(asyncomplete#get_source_info(l:source_name),'priority',0)
          call add(l:items, l:item)
        endif
      endfor
    endfor

    let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})

    call asyncomplete#preprocess_complete(a:options, l:items)
  endfunction

  let g:asyncomplete_preprocessor = [function('s:sort_by_priority_preprocessor')]

  if has_key(g:plugs, 'asyncomplete-ezfilter.vim')
    let g:asyncomplete_preprocessor =
          \ [function('asyncomplete#preprocessor#ezfilter#filter')]

    let s:FALSE = 0
    let g:asyncomplete#preprocessor#ezfilter#config = {}
    let g:asyncomplete#preprocessor#ezfilter#config = {
          \ '*': {ctx, items -> ctx.osa_filter(items, 2, s:FALSE)},
          \ }
  endif
endif
