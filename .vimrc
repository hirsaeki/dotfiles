" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)
"---------------------------------------------------------------------------
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set fileformats=unix,mac,dos
filetype off
filetype plugin indent off

" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

if $TMP == ""
  let $TMP = "/tmp"
endif

"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの幅
set tabstop=2
set softtabstop=2
set shiftwidth=2
set modelines=0
" タブをスペースに展開しない (expandtab:展開する)
set expandtab
" インデントはスマートインデント
set smartindent
" 自動的にインデントする (noautoindent:インデントしない)
set autoindent
" バックスペースでインデントや改行を削除できるようにする
set backspace=2
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set nowrapscan
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" コマンドライン補完をシェルっぽく
set wildmode=list:longest
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅
" 選択した文字をクリップボードに入れる
set clipboard=unnamed
" 保存していなくても別のファイルを表示できるようにする
set hidden
" 編集中のファイルが変更されたら自動で読み直す
set autoread

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,eol:<
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=1
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 画面を黒地に白にする (次行の先頭の " を削除すれば有効になる)
"colorscheme evening " (Windows用gvim使用時はgvimrcを編集すること)
"colorscheme koehler" (Windows用gvim使用時はgvimrcを編集すること)
colorscheme ap_dark8" (Windows用gvim使用時はgvimrcを編集すること)

"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
" バックアップファイルを環境変数TMPで指定されたディレクトリに作成
set backupdir=$TMP
" バックアップファイルの拡張子を.bakに設定
set backupext=.bak
" スワップファイルを環境変数TMPで指定されたディレクトリに作成
set directory=$TMP
"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    set term=beos-ansi
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" 括弧とクォートを自動補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

"---------------------------------------------------------------------------
"表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

"---------------------------------------------------------------------------
" 検索後、中央にフォーカスをあわせる
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"---------------------------------------------------------------------------
" 文字コード設定
autocmd FileType cvs    :set fileencoding=euc-jp
autocmd FileType svn    :set fileencoding=utf-8
autocmd FileType ruby   :set fileencoding=utf-8
autocmd FileType eruby  :set fileencoding=utf-8
autocmd FileType python :set fileencoding=utf-8

"---------------------------------------------------------------------------
" コマンドラインでのキーバインドを Emacs スタイルにする
" Ctrl+Aで行頭へ移動
:cnoremap <C-A>		<Home>
" Ctrl+Bで一文字戻る
:cnoremap <C-B>		<Left>
" Ctrl+Dでカーソルの下の文字を削除
:cnoremap <C-D>		<Del>
" Ctrl+Eで行末へ移動
:cnoremap <C-E>		<End>
" Ctrl+Fで一文字進む
:cnoremap <C-F>		<Right>
" Ctrl+Nでコマンドライン履歴を一つ進む
:cnoremap <C-N>		<Down>
" Ctrl+Pでコマンドライン履歴を一つ戻る
:cnoremap <C-P>		<Up>
" Alt+Ctrl+Bで前の単語へ移動
:cnoremap <Esc><C-B>	<S-Left>
" Alt+Ctrl+Fで次の単語へ移動
:cnoremap <Esc><C-F>	<S-Right> 

"---------------------------------------------------------------------------
" マーク位置へのジャンプを行だけでなく桁位置も復元できるようにする
map ' `
" Ctrl+Nで次のバッファを表示
map <C-N>   :bnext<CR>
" Ctrl+Pで前のバッファを表示
map <C-P>   :bprevious<CR>
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする
imap <C-K>  <ESC>"*pa
" Ctrl+Shift+Jで上に表示しているウィンドウをスクロールさせる
nnoremap <C-S-J> <C-W>k<C-E><C-W><C-W>

"---------------------------------------------------------------------------
" ファイルブラウザでバッファで開いているファイルのディレクトリを開く
:set browsedir=buffer

"---------------------------------------------------------------------------
" ファンクションキー設定
nmap <F2> ggVG
map  <F3> :Explore<CR>
nmap <F4> :close<CR>
nmap <F5> :ls<CR>
map  <F6> :bnext<CR>
map  <F7> :bprevious<CR>
map  <F8> <C-d>
map  <F9> <C-u>

"---------------------------------------------------------------------------

":filetype" command): >

imap <C-Space> <C-X><C-O>

" scroll
set scrolloff=999

" fold
set foldmethod=marker
set fillchars=vert:I " :vsplit (i)

" history
set history=200

" match time
set matchtime=2

" status line
set statusline=
set statusline+=[*%n]\  " バッファ番号
set statusline+=%f\     " ファイル名
set statusline+=%{'['.(&fenc!=''?&fenc:'?').'-'.&ff.']'} " 文字コード
" set statusline+=%{'['.GetShortEncodingJP().'-'.&ff.']'} " 文字コード
set statusline+=%m      " バッファ状態[+]とか
set statusline+=%r      " 読み取り専用フラグ
set statusline+=%h      " ヘルプバッファ
set statusline+=%w      " プレビューウィンドウ
set statusline+=%=      " 区切り
set statusline+=\ %{strftime('%c')}  " 時間
set statusline+=%4l,%2c " 行、列
set statusline+=%3p%%   " どこにいるか
set statusline+=%<      " 折り返しの指定

set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"--------------------------------------------------------------

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
  autocmd CursorHold *.toml syntax sync minlines=300
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
  " プラグイン読み込み＆キャッシュ作成
if has('win32')
  let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/vimfiles/dein.toml'
else
  let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.vim/dein.toml'
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

"==========================================
"neocomplete.vim
"==========================================
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
 
" ======================
" neosnippet settings ---
" ======================
"http://kazuph.hateblo.jp/entry/2013/01/19/193745

" <TAB>: completion.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/dotfiles/snippets'
let g:neosnippet#snippets_directory.=',' . '~/.vim/bundle/vim-snippets/snippets'

" ======================
" eskk settings ---
" ======================

exec 'source ' . '~/.vim/rc/plugins/azik.rc.vim'
let g:eskk#large_dictionary = "~/SKK-JISYO.L"
let g:eskk#enable_completion = 1
let g:eskk#egg_like_newline = 1
let g:eskk#log_file_level = 4
let g:eskk#server = {
\ 'host': 'kuro-box',
\ 'port': 1178,
\}

filetype plugin indent on
syntax on
colorscheme solarized
if has('gui_running')
  set background=light
else
  set background=dark
endif
