" vim:set ts=8 sts=2 sw=2 tw=0: (この行に関しては:help modelineを参照)

augroup vimrc
  autocmd!
augroup END set encoding=utf-8
scriptencoding utf-8
set ambiwidth=double
set termguicolors
set pumblend=10

" set system python path
" let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_prog = expand('~/miniconda/envs/nvim3/bin/python')
let g:python_host_prog = expand('~/miniconda/envs/nvim/bin/python')

"---------------------------------------------------------------------------
:
set fileencodings=utf-8,cp932,sjis,euc-jp,iso-2022-jp
set fileformats=unix,mac,dos
" neovim のターミナル実行時の表示くずれ対応
" if !has('gui_running') && has('nvim')
"   set guicursor=
" end
" カーソルの視認性
set cursorline
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

" ターミナルのスクロールsバック
set scrollback=100000

if $TMP ==# ''
  let $TMP = '/tmp'
endif

let mapleader = ","
"---------------------------------------------------------------------------
" 編集に関する設定:
"
" タブの幅
set tabstop=2
set softtabstop=2
set shiftwidth=2
set modelines=5
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
" 選択した文字をクリップボードに入れる
" set clipboard=unnamed
" 保存していなくても別のファイルを表示できるようにする
set hidden
" 編集中のファイルが変更されたら自動で読み直す
set autoread

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
" 行番号を非表示 (number:表示)
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
" set listchars=tab:>-,eol:<
set listchars=tab:>-,extends:<,trail:-,eol:<
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
"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
"set nobackup
" バックアップファイルを環境変数TMPで指定されたディレクトリに作成

let &backupdir=$HOME . '/.vimbackup'
call system('mkdir -p ' . shellescape(&backupdir))
" バックアップファイルの拡張子を.bakに設定
set backupext=.bak
" スワップファイルの置き場所作成
let &directory=&backupdir

" アンドゥファイルの置き場所作成
let &undodir=$HOME . '/.vimundo'
call system('mkdir -p '. shellescape(&undodir))

set undofile
"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

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
augroup FileEncoding
  autocmd!
  autocmd FileType cvs    :set fileencoding=euc-jp
  autocmd FileType svn    :set fileencoding=utf-8
  autocmd FileType ruby   :set fileencoding=utf-8
  autocmd FileType eruby  :set fileencoding=utf-8
  autocmd FileType python :set fileencoding=utf-8
augroup END

"---------------------------------------------------------------------------
" コマンドラインでのキーバインドを Emacs スタイルにする
" Ctrl+Aで行頭へ移動
:cnoremap <C-A>init.vim init.vim <Home>
" Ctrl+Bで一文字戻る
:cnoremap <C-B>init.vim init.vim <Left>
" Ctrl+Dでカーソルの下の文字を削除
:cnoremap <C-D>init.vim init.vim <Del>
" Ctrl+Eで行末へ移動
:cnoremap <C-E>init.vim init.vim <End>
" Ctrl+Fで一文字進む
:cnoremap <C-F>init.vim init.vim <Right>
" Ctrl+Nでコマンドライン履歴を一つ進む
:cnoremap <C-N>init.vim init.vim <Down>
" Ctrl+Pでコマンドライン履歴を一つ戻る
:cnoremap <C-P>init.vim init.vim <Up>
" Alt+Ctrl+Bで前の単語へ移動
:cnoremap <Esc><C-B>init.vim <S-Left>
" Alt+Ctrl+Fで次の単語へ移動
:cnoremap <Esc><C-F>init.vim <S-Right> 

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

"imap <C-Space> <C-X><C-O>

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

set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"--------------------------------------------------------------

" reset augroup
augroup MyAutoCmd
  autocmd!
  autocmd CursorHold *.toml syntax sync minlines=300
augroup END
" dein settings {{{
let g:dein#auto_recache = 0
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
" 
if v:version < 800 || ! has('nvim')
  let s:dein_clone = 'git clone --depth=1 -b 1.5 https://github.com/Shougo/dein.vim '  
else
  let s:dein_clone = 'git clone https://github.com/Shougo/dein.vim '  
endif
if has('nyaovim')
  let s:dein_dir = s:cache_home . '/nyaovim/dein'
elseif has('nvim')
  let s:dein_dir = s:cache_home . '/nvim/dein'
else
  let s:dein_dir = s:cache_home . '/vim/dein'
endif
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system(s:dein_clone . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .','. &runtimepath
  " プラグイン読み込み＆キャッシュ作成
let g:toml_dir = s:config_home . '/dein.vim'
let s:toml_file = g:toml_dir . '/dein.toml'
let s:toml_lazy_file = g:toml_dir . '/dein_lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy' : 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy' : 1})

  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" ======================
" eskk settings ---
" ======================
"if filereadable('~/.vim/rc/plugins/azik.rc.vim')
"  exec 'source ' . '~/.vim/rc/plugins/azik.rc.vim'
"endif
"let g:eskk#large_dictionary = '~/.SKK-JISYO.L'
"let g:eskk#enable_completion = 1
"let g:eskk#egg_like_newline = 1
"let g:eskk#log_file_level = 4
"let g:eskk#server = {
"\ 'host': 'kuro-box',
"\ 'port': 1178,
"\}

augroup TransparentBG
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=none
  autocmd Colorscheme * highlight NonText ctermbg=none
  autocmd Colorscheme * highlight LineNr ctermbg=none
  autocmd Colorscheme * highlight Folded ctermbg=none
  autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
augroup END

" augroup vimrc-auto-mkdir  " {{{
"   autocmd!
"   autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
"   function! s:auto_mkdir(dir, force)  " {{{
"     if !isdirectory(a:dir) && (a:force ||
"     \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
"       call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
"     endif
"   endfunction  " }}}
" augroup END  " }}}

if has('win32') && !has('gui_running') 
  colorscheme ap_dark8
  hi Visual ctermfg=7 ctermbg=12
  hi LineNr ctermfg=9
  hi Pmenu  ctermfg=0 ctermbg=9
  hi Folded ctermfg=10
else
  let g:solarized_contrast = 'high'
  let g:solarized_termtrans = 1
  colorscheme solarized8
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif
endif

if has('conceal')
  set conceallevel=1 concealcursor=
  let g:vim_json_syntax_conceal = 0
endif

"タブ、空白、改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

"全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
   
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif
