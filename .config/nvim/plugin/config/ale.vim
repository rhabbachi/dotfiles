if has_key(g:plugs, 'ale')
  " Check buffers only on |TextChangedI|.
  let g:ale_lint_on_text_changed='insert'
  " milliseconds delay after which the linters will be run after text is
  " changed.
  let g:ale_lint_delay=2000

  " Run linters when you leave insert mode.
  let g:ale_lint_on_insert_leave=1

  " Run linters to run on opening a file.
  let g:ale_lint_on_enter=-2

  " ELM
  let g:ale_elm_ls_use_global=1
  let g:ale_elm_format_use_global=1

  " PHP
  let g:ale_php_langserver_use_global=1
  let g:ale_php_langserver_executable=$PHP_LANGSERVER_EXECUTABLE_GLOBAL

  let g:ale_linters = {
        \   'elm': ['elm_ls'],
        \   'php': ['langserver'],
        \}

  let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'elm': ['elm-format'],
        \   'json': ['jq'],
        \}
endif
