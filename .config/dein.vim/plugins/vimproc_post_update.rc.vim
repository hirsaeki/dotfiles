if dein#util#_is_windows() 'tools\\update-dll-mingw'
elseif dein#util#_is_cygwin()
  let cmd = 'make -f make_cygwin.mak'
elseif executable('gmake')
  let cmd = 'gmake'
elseif executable('make')
  let cmd = 'make'
endif
let g:dein#plugin.build = cmd
