let b:ale_php_phpcs_standard = 'Drupal' " See https://www.drupal.org/node/1419988
let b:ale_php_phpcs_options = '--extensions="php,module,inc,install,test,profile,theme,css,info,txt,md"'
let b:ale_linters = {
  \   'php': ['langserver', 'phpcs', 'remove_trailing_lines', 'trim_whitespace'],
  \}
