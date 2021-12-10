if has_key(g:plugs, 'quick-scope')
	" Map the leader key + q to toggle quick-scope's highlighting in
	" normal/visual mode.  Note that you must use nmap/xmap instead of
	" their non-recursive versions (nnoremap/xnoremap).
	nmap <leader>qs <plug>(QuickScopeToggle)
	xmap <leader>qs <plug>(QuickScopeToggle)

	let g:qs_buftype_blacklist = ['terminal', 'nofile']

	" Trigger a highlight in the appropriate direction when pressing these
	" keys:
	let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

	" https://github.com/unblevable/quick-scope#customize-colors
	augroup qs_colors
	  autocmd!
	  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
	  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
	augroup END

	if exists('g:vscode')
		" https://github.com/asvetliakov/vscode-neovim#quick-scope
		" quick-scope plugin uses default vim HL groups by default but they are
		" normally ignored.
		highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
		highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
	endif
end
