" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ ddc#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

inoremap <expr><C-g>       ddc#refresh_candidates()
inoremap <silent><expr><C-l>      ddc#complete_common_string()

call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'nextword', 'vsnip', 'file'])

call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ 'nextword': {
      \   'mark': 'nextword',
      \ },
      \ 'file': {
      \   'mark': 'F',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*',
      \ },
      \ 'nvim-lsp': {
      \   'mark': 'LSP',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
      \ },
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank'],
      \ },
      \ })

call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxsize': 500},
      \ 'file': {'smartCase': v:true},
      \ })

call ddc#enable()
