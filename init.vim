"----------------------------------------------------------
" エンコード
"----------------------------------------------------------
set encoding=utf-8 " 読み込み時の文字コードの設定
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=utf-8,euc-jp,sjis,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

"----------------------------------------------------------
" deinの設定
"----------------------------------------------------------
" インストールディレクトリの指定
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_file = expand('~/.config/nvim/dein') . '/plugins.toml'
let s:toml_dir = expand('~/.config/nvim/dein/plugins')
" dein.vim ディレクトリがruntimepathに入っていない場合、追加
if match( &runtimepath, '/dein.vim' ) == -1
  " dein_repo_dir で指定した場所に dein.vim が無い場合、git cloneしてくる
	if !isdirectory(s:dein_repo_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
	endif
	execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif
" dein の設定
if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)
  " 各プラグインのtomlを読み込む
	call dein#load_toml( s:toml_dir . '/tcomment_vim.toml', {} )
	"call dein#load_toml( s:toml_dir . '/vim-surround.toml', {} )
	"call dein#load_toml( s:toml_dir . '/yankround.vim.toml', {} )
	call dein#load_toml( s:toml_dir . '/neoterm.toml', {} )
	call dein#load_toml( s:toml_dir . '/lightline.vim.toml', {} )
	"call dein#load_toml( s:toml_dir . '/ctrlp.vim.toml', {} )
	call dein#load_toml( s:toml_dir . '/iceberg.vim.toml', {} )
	call dein#load_toml( s:toml_dir . '/gruvbox-material.toml', {} )
	call dein#load_toml( s:toml_dir . '/smart_tabline.vim.toml', {} )
	"call dein#load_toml( s:toml_dir . '/vim-altercmd.toml', {} )
	call dein#load_toml( s:toml_dir . '/defx-git.toml', {} )
	call dein#load_toml( s:toml_dir . '/defx-icons.toml', {} )
	"call dein#load_toml( s:toml_dir . '/vim-devicons.toml', {} )
	call dein#load_toml( s:toml_dir . '/defx.nvim.toml', {} )
	call dein#load_toml( s:toml_dir . '/deoplete.nvim.toml', {} )
	call dein#load_toml( s:toml_dir . '/vim-polyglot.toml', {} )
  call dein#end()
	call dein#save_state()
endif
" 各プラグインのインストールチェック（なかったら自動的に追加される）
if dein#check_install()
	call dein#install()
endif

"----------------------------------------------------------
" colorschemeの設定
"----------------------------------------------------------
set termguicolors   " 24bitカラーに対応させる
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色
"colorscheme iceberg " カラースキームにicebergを設定する
"set background=dark
"let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material
" colorscheme iceberg
"----------------------------------------------------------
" terminalの設定
"----------------------------------------------------------
" neovim terminal mapping
if has('nvim')
	" 新しいタブでターミナルを起動
	nnoremap <C-t><C-t> :tabe<CR>:terminal<CR>
	" Ctrl + q でターミナルを終了
	tnoremap <C-q> <C-\><C-n>:q<CR>
	" ESCでターミナルモードからノーマルモードへ
	tnoremap <ESC> <C-\><C-n>
endif

"----------------------------------------------------------
" クリップボードの設定
"----------------------------------------------------------
set clipboard+=unnamedplus

"----------------------------------------------------------
" インデント・タブ
"----------------------------------------------------------
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set cindent " Cプログラムファイルの自動インデントを始める
set smarttab " 新しい行を作ったときに高度な自動インデントを行う
set expandtab " タブ入力を複数の空白入力に置き換える

set shiftwidth=4 " smartindentで増減する幅
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set list  " 不可視文字を表示する
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲ " デフォルト不可視文字は美しくないのでUnicodeで綺麗に

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

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
  autocmd FileType c           setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
endif

"----------------------------------------------------------
" モード変更
"----------------------------------------------------------
inoremap jj <Esc>

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set wrapscan " 検索時に最後まで行ったら最初に戻る
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR> " ESCキー2度押しでハイライトの切り替え
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
 
"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト
set cursorcolumn " カーソルラインをハイライト
set virtualedit=onemore " 行末の1文字先までカーソルを移動できるように
set visualbell " ビープ音を可視化

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
" バックスペースキーの有効化
set backspace=indent,eol,start
" カッコ・タグの対応表示
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数
