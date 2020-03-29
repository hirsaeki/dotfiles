let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7

if exists('g:loaded_lightline')
  " lightline.vim側で描画するのでdeniteでstatuslineを描画しないようにする
  call denite#custom#option('default', 'statusline', v:false)
endif

" Change denite default options
call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })
