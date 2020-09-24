" Ctags {
" Make tags placed in .git/tags file available in all levels of a repository
" let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
" if gitroot != ''
"     let &tags = &tags . ',' . gitroot . '/.git/tags'
" endif

if has_key(g:plugs, 'tagbar')
    nnoremap <silent> <Leader>tt :TagbarToggle<CR>

    " If you set this option the cursor will move to the Tagbar window
    " when it is opened.
    let g:tagbar_autofocus = 1

    " If this option is set the tags are sorted according to their
    " name. If it is unset they are sorted according to their order in
    " the source file.
    let g:tagbar_sort = 0

    " If this option is set a case-insensitive comparison is used when
    " the tags are sorted according to their name. If it is unset a
    " case-sensitive comparison is used.
    let g:tagbar_case_insensitive = 1

    " If you set this option the Tagbar window will automatically
    " close when you jump to a tag.
    let g:tagbar_autoclose = 1

    " Width of the Tagbar window in characters.
    let g:tagbar_width = 50

    " Width of the Tagbar window when zoomed.
    let g:tagbar_zoomwidth = 1
endif

if has_key(g:plugs, 'vim-gutentags')
    let g:gutentags_generate_on_new = 1
    let g:gutentags_generate_on_missing = 1
    let g:gutentags_generate_on_write = 1
    let g:gutentags_generate_on_empty_buffer = 0

    " Custom root markers in the current file's directory and its parent
    " directories.
    let g:gutentags_project_root = ['package.json']

    let g:gutentags_cache_dir = expand('~/.cache/nvim/gutentags')
    let gutentags_exclude_filetypes = ['gitcommit', 'netrw', 'GV', 'git']
    let g:gutentags_ctags_exclude = [
                \ '*/tests/*',
                \ 'build',
                \ 'dist',
                \ '*sites/*/files/*',
                \ 'bin',
                \ 'node_modules',
                \ 'bower_components',
                \ 'cache',
                \ 'compiled',
                \ 'docs',
                \ 'example',
                \ 'bundle',
                \ 'vendor',
                \ '*.md',
                \ '*-lock.json',
                \ '*.lock',
                \ '*bundle*.js',
                \ '*build*.js',
                \ '.*rc*',
                \ '*.json',
                \ '*.min.*',
                \ '*.map',
                \ '*.bak',
                \ '*.zip',
                \ '*.pyc',
                \ '*.class',
                \ '*.sln',
                \ '*.Master',
                \ '*.csproj',
                \ '*.tmp',
                \ '*.csproj.user',
                \ '*.cache',
                \ '*.pdb',
                \ 'tags*',
                \ 'cscope.*',
                \ '*.css',
                \ '*.less',
                \ '*.scss',
                \ '*.exe', '*.dll',
                \ '*.mp3', '*.ogg', '*.flac',
                \ '*.swp', '*.swo',
                \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
                \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
                \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
                \ ]

    " In case of emergency uncomment.
    " let g:gutentags_trace = 1
endif

if has_key(g:plugs, 'vista.vim')
    nnoremap <silent> <Leader>tt :Vista!!<CR>

    " Executive used when opening vista sidebar without specifying it.
    " See all the avaliable executives via `:echo g:vista#executives`.
    let g:vista_default_executive = 'ale'

    " Ignore some kinds of tags or symbols.
    let g:vista_ignore_kinds = ['gitcommit', 'netrw', 'GV', 'git']

    " close the vista window automatically close when you jump to a symbol.
    let g:vista_close_on_jump=1

    " Ensure you have installed some decent font to show these pretty symbols,
    " then you can enable icon for the kind.
    let g:vista#renderer#enable_icon = 1

    " The default icons can't be suitable for all the filetypes, you can
    " extend it as you wish.
    let g:vista#renderer#icons = {
                \   "function": "ƒ",
                \   "variable": "x",
                \  }
endif

" }

