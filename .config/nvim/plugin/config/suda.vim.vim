if has_key(g:plugs, 'suda.vim')
  " https://github.com/lambdalisue/suda.vim
  " multiple protocols can be defined too
  let g:suda#prefix = ['suda://', 'sudo://', '_://']

  " Automatically switch a buffer name when the target file is not readable or
  " writable.
  let g:suda_smart_edit = 1
endif
