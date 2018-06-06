set encoding utf-8
scriptencoding utf-8
augroup FileEncoding
  autocmd!
  autocmd FileType python setlocal completeopt-=preview
augroup END

let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signature = 0
" コード参照のキーバインドを登録
let g:jedi#goto_command = '<Leader>d'
