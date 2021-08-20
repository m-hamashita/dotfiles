set encoding=utf-8

set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
scriptencoding utf-8

if has('persistent_undo')
   set undodir=~/.vim/undo
   set undofile
endif

" jjでnormal modeに
inoremap <silent> jj <ESC>:<C-u>w<CR>

" 10進数でインクリメントする
set nrformats=
"括弧の対応をハイライト
set showmatch
"保存時の文字コード
set fileencoding=utf-8
"□や○文字が崩れる問題を解決
set ambiwidth=double
"ヤンクした時にクリップボードにコピーする
set clipboard=unnamed,autoselect
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

"行頭へ移動
inoremap <C-a> <C-o>^
"行末へ移動
inoremap <C-l> <C-o>$


filetype plugin indent on


colorscheme slate

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline
