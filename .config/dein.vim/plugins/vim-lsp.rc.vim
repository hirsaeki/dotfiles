" registar pyls to vim-lsp
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_information = {'text': 'i'}
let g:lsp_signs_hint = {'text': '?'}
" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" pylsの設定。LinterのON/OFFなどが可能
let s:pyls_config = {'pyls': {'plugins': {
    \   'pycodestyle': {'enabled': v:true},
    \   'pydocstyle': {'enabled': v:false},
    \   'pylint': {'enabled': v:false},
    \   'flake8': {'enabled': v:true},
    \   'jedi_definition': {
    \     'follow_imports': v:true,
    \     'follow_builtin_imports': v:true,
    \   },
    \ }}}

if (executable('pyls'))
  augroup LspPython
    autocmd!
    au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python']
    \ })
  augroup END
endif

if (executable('yaml-language-server'))
  augroup LspYaml
    autocmd!
    au User lsp_setup call lsp#register_server({
    \ 'name': 'yls',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'yaml-language-server --stdio']},
    \ 'whitelist': ['yaml', 'yaml-ansible'],
    \ 'workspace_config': {
    \   'yaml': {
    \     'format.enable': 'true',
    \     'completion': 'true',
    \     'schemas': {
    \       'kubernetes': '*.yaml'
    \     }
    \   }
    \ }
    \ })
  augroup END
endif

if executable('terraform-lsp')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'terraform-lsp',
    \ 'cmd': {server_info->['terraform-lsp']},
    \ 'whitelist': ['terraform','tf'],
    \ })
endif

" 定義ジャンプ(デフォルトのctagsによるジャンプを上書きしているのでこのあたりは好みが別れます)
nnoremap <C-h> :<C-u>LspDefinition<CR>
" 定義情報のホバー表示
nnoremap K :<C-u>LspHover<CR>
" 名前変更
nnoremap <LocalLeader>R :<C-u>LspRename<CR>
" 参照検索
nnoremap <LocalLeader>n :<C-u>LspReferences<CR>
" Lint結果をQuickFixで表示
nnoremap <LocalLeader>f :<C-u>LspDocumentDiagnostics<CR>
" テキスト整形
nnoremap <LocalLeader>s :<C-u>LspDocumentFormat<CR>
