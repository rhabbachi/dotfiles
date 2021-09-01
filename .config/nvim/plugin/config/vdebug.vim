if has_key(g:plugs, 'vdebug')
    if !exists('g:vdebug_options')
      let g:vdebug_options = {}
    endif

	let g:vdebug_options.path_maps = {
				\ '/var/www': getcwd(),
				\ '/usr/local/dkan-tools': expand('~/Desktop/civicactions/dkan-tools/')
				\ }
endif
