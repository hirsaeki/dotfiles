let g:deoplete#enable_at_startup = 1

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
call deoplete#custom#source('buffer', {
  \   'require_same_filetype': v:false,
  \ })
call deoplete#custom#source('lsp', {
  \   'matcher': ['matcher_fuzzy'],
  \   'rank': 90,
  \ })
call deoplete#custom#source('ultisnips', {
  \   'matcher': ['matcher_fuzzy'],
  \   'rank': 80,
  \ })
call deoplete#custom#source('look', {
  \   'matcher': ['matcher_fuzzy'],
  \   'rank': 60,
  \ })
call deoplete#custom#option({
  \   'auto_complete_delay': 0,
  \   'auto_reflesh_delay': 20,
  \   'reflesh_always': 20,
  \   'camel_case': v:true,
  \   'smart_case': v:true,
  \   'max_list': 300,
  \ })
"call deoplete#enable_logging("DEBUG", "deoplete.log")
