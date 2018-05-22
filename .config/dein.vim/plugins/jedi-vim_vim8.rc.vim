autocmd FileType python setlocal completeopt-=preview
autocmd FileType python setlocal omnifunc=jedi#completions

let g:jedi#auto_initialization    = 1 " Disable the default initialization routine
let g:jedi#auto_vim_configuration = 0 " Don't change 'completeopt'
let g:jedi#popup_on_dot           = 0 " Manually press the completion key
let g:jedi#popup_select_first     = 0 " Don't select first completion entry
let g:jedi#show_call_signatures   = 0 " Avoid popups bugs
" コード参照のキーバインドを登録

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
let g:jedi#goto_command = "<Leader>d"
