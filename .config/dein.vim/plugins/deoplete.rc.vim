if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

inoremap <expr><C-g>       deoplete#refresh()
inoremap <expr><C-e>       deoplete#cancel_popup()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction

call deoplete#custom#source('_', {
  \ })
call deoplete#custom#source('ultisnips', {
  \   'matcher': ['matcher_fuzzy'],
  \   'rank': 9999,
  \ })
call deoplete#custom#source('look', {
  \   'matcher': ['matcher_fuzzy'],
  \   'rank': 1,
  \ })
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 50
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000
