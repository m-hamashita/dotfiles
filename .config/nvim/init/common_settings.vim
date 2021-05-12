set shell=/bin/sh
set encoding=utf-8

set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf-8

if has('persistent_undo')
   set undodir=~/.vim/undo
   set undofile
endif

" let g:python_host_prog = system('(type pyenv &>/dev/null && echo -n $(pyenv root)/versions/$(pyenv global | grep python2)/bin/python) || echo -n $(which python2)')
let g:python_host_prog = '/usr/bin/python2.7'
" let g:python3_host_prog = system('(type pyenv &>/dev/null && echo $(pyenv root)/versions/3.8.1/bin/python) || echo -n $(which python3)')
" let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '~/.pyenv/shims/python3'


augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.dig setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.c setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" digdag
autocmd BufNewFile,BufRead *.dig set filetype=yaml
autocmd Syntax yaml setl indentkeys-=<:>

"全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/
set backspace=indent,eol,start

"意味ないかも
let $PATH = "~/.pyenv/shims:".$PATH

"カーソル位置を復元
"autocmd BufWinLeave ?* silent mkview
"autocmd BufWinEnter ?* silent loadview
autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

" _ を単語に含めない
" set isk-=_
" ctags
set tags=./tags;,tags;
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
set tabstop=4
" smartindentで増減する幅
set shiftwidth=4
"カーソルラインの表示
set cursorline
" tab to space
set expandtab
" softtabstop
set softtabstop=0
" autoindent
set autoindent
" splitright
set splitright

" fold の設定
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2


" ハイライトする桁数
set synmaxcol=600
" 入力中のコマンドの表示
set showcmd
" ステータスラインを常に表示
set laststatus=2
" ファイルナンバー表示
set statusline=[%n]
" ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
" ファイル名表示
set statusline+=%<%F
" 変更のチェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" ファイルフォーマット表示
set statusline+=[%{&fileformat}]
" 文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
" ファイルタイプ表示
set statusline+=%y
" ここからツールバー右側
set statusline+=%=
" skk.vimの状態
"set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}
" 文字バイト数/カラム番号
" set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
" 現在文字列/全体列表示
set statusline+=[C=%c/%{col('$')-1}]
" 現在文字行/全体行表示
set statusline+=[L=%l/%L]
" 現在のファイルの文字数をカウント
" set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]
" 現在行が全体行の何%か表示
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
" shift+K でカーソル下の word のヘルプを開くことができる
" set keywordprg=:help
"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline
