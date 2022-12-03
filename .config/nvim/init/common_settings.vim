set shell=/bin/sh
scriptencoding utf-8

set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

" Unable netrw
" let loaded_netrwPlugin = 1

" terminal mode で使用する shell を設定
set shell=fish

if has('persistent_undo')
   set undodir=~/.vim/undo
   set undofile
endif

" _ を単語に含めない
" set isk-=_
" ctags
set tags=./tags;,tags;
" bufferの切り替えときに保存していないのを無視する
set hidden
" 括弧の対応をハイライト
set showmatch
" 保存時の文字コード
set fileencoding=utf-8
" □や○文字が崩れる問題を解決
" if exists('g:vscode')
"   set ambiwidth=double
" ヤンクした時にクリップボードにコピーする
" set clipboard=unnamed,autoselect
set clipboard+=unnamedplus
syntax on
" filetypeによってインデントを変更する
filetype plugin indent on
filetype indent on

" 行数を表示する
set number
" ルーラーを表示
set noruler
" バックスペースキーで行頭を削除する
set backspace=indent,eol,start
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent
" 画面上でタブ文字が占める幅
set tabstop=4
" smartindentで増減する幅
set shiftwidth=4
" カーソルラインの表示
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

" ハイライトする桁数(重さ軽減のため)
set synmaxcol=600
" 入力中のコマンドの表示
set showcmd

"-------Search--------
" 検索結果をハイライト表示する
set hlsearch
" インクリメンタルサーチを有効にする
set incsearch
" 大文字小文字を区別しない
set ignorecase
" 大文字で検索されたら対象を大文字限定にする
set smartcase
" 行末まで検索したら行頭に戻る
set wrapscan

"---------------------

" カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline


let g:python_host_prog = '/usr/bin/python2.7'
let g:python3_host_prog = system('type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(cat $(pyenv root)/version | head -n 1)/bin/python" || echo -n $(which python)')
let g:pip_command_path = '~/.local/bin/'



augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.dig setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " autocmd BufNewFile,BufRead *.cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " autocmd BufNewFile,BufRead *.c setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2
  " autocmd BufNewFile,BufRead *.md inoremap <buffer> <Tab> <Esc>>>lla
  autocmd BufNewFile,BufRead *.md nnoremap <buffer> <Tab> >>ll
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


augroup filetypes
  autocmd!
  " digdag
  autocmd BufNewFile,BufRead *.dig set filetype=yaml
  autocmd Syntax yaml setl indentkeys-=<:>
  " textlint
  autocmd BufRead,BufNewFile .textlintrc setlocal filetype=json
augroup END

" 全角スペースの可視化
augroup zenkakuVisual
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
  au BufNewFile,BufRead * match ZenkakuSpace /　/
augroup END

" 意味ないかも
let $PATH = '~/.pyenv/shims:'.$PATH

" カーソル位置を復元
augroup cursorRestore
  autocmd!
  " autocmd BufWinLeave ?* silent mkview
  " autocmd BufWinEnter ?* silent loadview
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
