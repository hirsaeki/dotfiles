autocmd FileType python setlocal completeopt-=preview

let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signature = 0
" コード参照のキーバインドを登録
let g:jedi#goto_command = "<Leader>d"
