set encoding=utf-8

set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
scriptencoding utf-8

if has('persistent_undo')
   set undodir=~/.vim/undo
   set undofile
endif

" bufferの切り替えときに保存していないのを無視する
set hidden 
"括弧の対応をハイライト
set showmatch
"保存時の文字コード
set fileencoding=utf-8
"□や○文字が崩れる問題を解決
set ambiwidth=double
"ヤンクした時にクリップボードにコピーする
" set clipboard=unnamed,autoselect
set clipboard+=unnamedplus
syntax on
"filetypeによってインデントを変更する
filetype plugin indent on
filetype indent on
"行数を表示する
set number
"ルーラーを表示
set ruler
"バックスペースキーで行頭を削除する
set backspace=indent,eol,start
"改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
"画面上でタブ文字が占める幅
set tabstop=2
" smartindentで増減する幅
set shiftwidth=2
"カーソルラインの表示
set cursorline
" tab to space
set expandtab
" softtabstop
set softtabstop=0
" autoindent
set autoindent

"全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/
set backspace=indent,eol,start

"入力中のコマンドの表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ヘルプページなら[HELP]と表示
set statusline+=%h
"プレビューウインドウなら[Prevew]と表示
set statusline+=%w
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y
"ここからツールバー右側
set statusline+=%=
"skk.vimの状態
"set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}
"文字バイト数/カラム番号
" set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
"現在文字列/全体列表示
set statusline+=[C=%c/%{col('$')-1}]
"現在文字行/全体行表示
set statusline+=[L=%l/%L]
"現在のファイルの文字数をカウント
" set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]
"現在行が全体行の何%か表示
set statusline+=[%p%%]

"-------Search--------
"検索結果をハイライト表示する
set hlsearch
"インクリメンタルサーチを有効にする
set incsearch
"大文字小文字を区別しない
set ignorecase
"大文字で検索されたら対象を大文字限定にする
set smartcase
"行末まで検索したら行頭に戻る
set wrapscan
"---------------------

"カーソル位置を復元
"autocmd BufWinLeave ?* silent mkview
"autocmd BufWinEnter ?* silent loadview
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif


" ショートカット
nnoremap s <Nop>
nnoremap sj <C-w>j "タブ移動系
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

noremap <S-h>   ^ "カーソル移動系shift+hjkl
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $

nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

"Insertmodeで<C-C>でESCと同義
" inoremap <C-C> <ESC>
"Enterで改行
nnoremap <CR> o<ESC>

" 複数行を選択して連続してインデントできるようにする
vnoremap > >gv
vnoremap < <gv

"折返しがある場合次の行に行くのではなく，そのまま下に行く 
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" jjでnormal modeに
inoremap <silent> jj <ESC>:<C-u>w<CR>


"行頭へ移動
inoremap <C-a> <C-o>^
"行末へ移動
inoremap <C-l> <C-o>$

"新しいタブ
nnoremap st :<C-u>tabnew<CR>
"Unite
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>


"jedi-vimのため
" let g:python3_host_prog = expand('~/.pyenv/versions/shims/python3')

" dein scripts----------------------- 
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

	call dein#add('vim-airline/vim-airline')
  
	"vim-fugitive Gitクライアントプラグイン
	"vimから離れずにGitが使える
	call dein#add('tpope/vim-fugitive')

	"vim-gitgutter gitのHEADからのコード追加，削除，変更を左端に表示
	call dein#add('airblade/vim-gitgutter')
	
	"deoplete-jedi Pythonの自動補完
	call dein#add('zchee/deoplete-jedi')
  "vim-virtualenv パス自動追加プラグイン
	call dein#add('jmcantrell/vim-virtualenv')
	"vim-python-pep8-indent 自動でpep8準拠のインデント
  call dein#add('Vimjas/vim-python-pep8-indent')
	"jedi-vim 自動補完などPythonのコーディングをする際の様々な便利ツールを提供している

	"vim-clang 
  call dein#add('justmao945/vim-clang')
  "unite.vim
  call dein#add('Shougo/unite.vim')
  call dein#add('ujihisa/unite-colorscheme')
  "補完してくれるやつ
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim') 
    " ディレクトリをツリー表示とショートカットCtrl+eで開く
	call dein#add('scrooloose/nerdtree')
	" VimからThe Silver Searcherが使えるようにするやつ
	call dein#add('rking/ag.vim') 
  " 括弧とかいい感じに補完するやつ
  call dein#add('cohama/lexima.vim')		
  " 括弧に色を付けるやつ
	call dein#add('luochen1990/rainbow')

  
  "syntastic 
	call dein#add('vim-syntastic/syntastic')	





	" deolate.nvimの設定
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-clang')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  "この下の設定うまくいってない.
	let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/7.0.0/lib/libclang.dylib'
 	let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/7.0.0/lib/clang'
 	" g:deoplete#sources#clang#libclang_path
  " g:deoplete#sources#clang#clang_header
  
  "補完や英単語検索
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neco-syntax')
  call dein#add('ujihisa/neco-look') 
	
	" ALE linter実行プラグイン　静的解析
	call dein#add('w0rp/ale')	
  
  "sessionが保存されるらしい
  call dein#add('tpope/vim-obsession')
	
	
	
	call dein#load_toml('~/.config/nvim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/rc/dein_lazy.toml', {'lazy': 1})

 

	call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"End dein scripts -----------------------------------------------

filetype plugin indent on
syntax enable

" leximaの設定 (末尾以外では自動クローズしない)
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '(', 'input': '('})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': "'", 'input': "'"})
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '"', 'input': '"'})
"自動クローズした文字が次の行にあってもタイプできるように(よくわかってない)
call lexima#add_rule({'at': '\%#\n\s*}', 'char': '}', 'input': '}', 'delete': '}'})
call lexima#add_rule({'at': '\%#\n\s*}', 'char': ')', 'input': ')', 'delete': ')'})
call lexima#add_rule({'at': '\%#\n\s*}', 'char': "'", 'input': "'", 'delete': "'"})
call lexima#add_rule({'at': '\%#\n\s*}', 'char': '"', 'input': '"', 'delete': '"'})
" TAB押したら括弧の右に行くようにする
call lexima#add_rule({'char': '<TAB>', 'at': '\%#)', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#"', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#''', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#]', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#}', 'leave': 1})




"括弧に色つけるやつの設定
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


""Neco-look 設定
if !exists('g:neocomplete#text_mode_filetypes')
		let g:neocomplete#text_mode_filetypes={}
endif
let g:neocomplete#text_mode_filetypes={
		\ 'rst' : 1,
		\ 'markdown' : 1,
		\ 'gitrebase' : 1,
		\ 'gitcommit' : 1,
		\ 'vcs-commit' : 1,
		\ 'hybrid' : 1,
		\ 'text' : 1,
		\ 'help' : 1,
		\ 'tex' : 1,
		\ }
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mark*} set filetype=markdown
""Neco-look------


"jedi-vim
let g:jedi#documentation_command = "<P>"

" パワーラインでかっこよく
let g:airline_powerline_fonts = 1
" カラーテーマ指定してかっこよく
let g:airline_theme = 'badwolf'
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1


""""""""ALE設定"""""""""""""""""""""""""""""""""""""""""""""""
" エラー行に表示するマーク
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" エラー表示の列を常時表示
let g:ale_sign_column_always = 1

" ファイルを開いたときにlint実行
let g:ale_lint_on_enter = 1
" ファイルを保存したときにlint実行
let g:ale_lint_on_save = 1
" 編集中のlintはしない
let g:ale_lint_on_text_changed = 'never'

" lint結果をロケーションリストとQuickFixには表示しない
" 出てると結構うざいしQuickFixを書き換えられるのは困る
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

" 有効にするlinter
let g:ale_linters = {
\   'python': ['flake8'],
\}

" ALE用プレフィックス
nmap [ale] <Nop>
map <C-f> [ale]
" エラー行にジャンプ
nnoremap <silent> [ale]<C-p> <Plug>(ale_previous)
nnoremap <silent> [ale]<C-n> <Plug>(ale_next)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




 

"vim起動時にNERDTree起動
"autocmd VimEnter * execute 'NERDTree'
nnoremap <silent><C-e> :NERDTreeToggle<CR> 
" NERDTreeで隠しファイルも表示する
let NERDTreeShowHidden=1 
" colorscheme
colorscheme wombat256mod

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline



