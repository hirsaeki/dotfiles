if dein#util#_is_windows()
  let g:cmd = 'tools\\update-dll-mingw'
elseif dein#util#_is_cygwin()
  let g:cmd = 'make -f make_cygwin.mak'
elseif executable('gmake')
  let g:cmd = 'gmake'
elseif executable('make')
  let g:cmd = 'make'
endif
let g:dein#plugin.build = g:cmd
