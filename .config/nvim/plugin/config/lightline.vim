" vim:tw=78:ts=2:sts=2:sw=2:ft=help:norl:
if has_key(g:plugs, 'lightline.vim')
let g:lightline = {}


" let g:lightline.component_expand = {
"       \  'linter_checking': 'lightline#ale#checking',
"       \  'linter_infos': 'lightline#ale#infos',
"       \  'linter_warnings': 'lightline#ale#warnings',
"       \  'linter_errors': 'lightline#ale#errors',
"       \  'linter_ok': 'lightline#ale#ok',
"       \ }

" let g:lightline.component_type = {
"       \     'linter_checking': 'right',
"       \     'linter_infos': 'right',
"       \     'linter_warnings': 'warning',
"       \     'linter_errors': 'error',
"       \     'linter_ok': 'right',
"       \ }

" let g:lightline.active = { 
" 		  \ 'right': [[ 
" 		  \ 'linter_checking', 
" 		  \ 'linter_errors', 
" 		  \ 'linter_warnings', 
" 		  \ 'linter_infos', 
" 		  \ 'linter_ok' ]] 
" 		  \ }
endif
