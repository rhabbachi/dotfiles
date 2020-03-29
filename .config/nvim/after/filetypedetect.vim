augroup filetypedetect
  " Drupal files should be identified as PHP files.
  au! BufRead,BufNewFile *.module setfiletype drupal.php
  au! BufRead,BufNewFile *.install setfiletype drupal.php
  au! BufRead,BufNewFile *.test setfiletype drupal.php
  au! BufRead,BufNewFile *.inc setfiletype drupal.php
  au! BufRead,BufNewFile *.profile setfiletype drupal.php
  au! BufRead,BufNewFile *.view setfiletype drupal.php
  au! BufRead,BufNewFile *.theme setfiletype drupal.php
  au! BufNewFile,BufRead *.html.twig setfiletype=html.twig

  " markdown syntax highlighting
  au! BufRead,BufNewFile *.md set filetype=markdown
augroup END
