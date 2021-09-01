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
end
