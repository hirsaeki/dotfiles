"use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion  =  1
let g:neocomplete#max_keyword_width = 10000
let g:neocomplete#auto_completion_start_length = 2

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
" Define text-type
if !exists('g:neocomplete#text_mode_filetypes')
  let g:neocomplete#text_mode_filetype = {}
endif
let g:neocomplete#text_mode_filetypes = {
      \ 'javascript': 1,
      \ 'gitrebase': 1,
      \ 'gitcommit': 1,
      \ 'text': 1,
      \ 'java': 1,
      \}

" Plugin key-mappings.
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()
inoremap <expr><CR>   pumvisible() ? neocomplete#close_popup()  : "<CR>"

let s:neco_dicts_dir = $HOME . '/dicts'
if isdirectory(s:neco_dicts_dir)
  let g:neocomplete#sources#dictionary#dictionaries ={
  \   
  \ }
endif
let g:neocomplete#data_directory = '~/.vim/cache/neocomplete'
