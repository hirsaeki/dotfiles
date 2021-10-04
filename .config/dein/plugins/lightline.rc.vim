if !has('gui_running')
  set t_Co=256
endif
" LightlineMode の代わりにMymodeを使用
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'filename', 'filepath' ],
        \             [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightlineModified',
        \   'readonly': 'LightlineReadonly',
        \   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
        \   'filepath': 'LightlineFilepath',
        \   'fileformat': 'LightlineFileformat',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \   'mode': 'LightlineMode',
        \ }
        \ }

function! LightlineModified()
  return &filetype =~? 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
  return ('' !=? LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&filetype ==? 'vimfiler' ? vimfiler#get_status_string() :
        \  &filetype ==? 'unite' ? unite#get_status_string() :
        \  &filetype ==? 'vimshell' ? vimshell#get_status_string() :
        \ '' !=? expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' !=? LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFilepath()
  return (&filetype ==? 'vimfiler' ? '' :
        \  &filetype ==? 'unite' ? '':
        \  &filetype ==? 'vimshell' ? '':
        \ '' !=? expand('%:h') ? pathshorten(expand('%:h')) : '')
endfunction

function! LightlineFugitive()
  if &filetype !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
