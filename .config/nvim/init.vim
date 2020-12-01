set encoding=utf-8

set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf-8

if has('persistent_undo')
   set undodir=~/.vim/undo
   set undofile
endif

let g:python_host_prog = system('(type pyenv &>/dev/null && echo -n $(pyenv root)/versions/$(pyenv global | grep python2)/bin/python) || echo -n $(which python2)')
let g:python3_host_prog = system('(type pyenv &>/dev/null && echo -n $(pyenv root)/versions/3.8.1/bin/python) || echo -n $(which python3)')
" let g:python_host_prog = '/usr/local/bin/python'
" let g:python3_host_prog = '/usr/local/bin/python3'

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

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.dig setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" python file 起動時，Vista finder 起動
" autocmd BufNewFile,BufRead *.py execute 'Vista'

" digdag
autocmd BufNewFile,BufRead *.dig set filetype=yaml
autocmd Syntax yaml setl indentkeys-=<:>

"全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/
set backspace=indent,eol,start

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


" noremap <S-h>   ^ "カーソル移動系shift+hjkl
" noremap <S-j>   }
" noremap <S-k>   {
" noremap <S-l>   $

nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" ctags
autocmd FileType python nnoremap <C-]> g<C-]>
autocmd FileType python inoremap <C-]> <ESC>g<C-]>
autocmd FileType python nnoremap <silent><C-[> <C-t>
" vim-go
autocmd FileType go nnoremap <silent> <C-[> :GoDefPop<CR>
autocmd FileType go nmap <leader>s <Plug>(go-def-split)
autocmd FileType go nmap <leader>v <Plug>(go-def-vertical)

command Tmux e ~/.tmux_cheatsheet.md
command Work e ~/.work_cheatsheet.md
command Cheat e ~/.vim_cheatsheet.md
command Shell e ~/.shell_cheatsheet.md
command Prog e ~/.prog_cheatsheet.md
command Path echo expand("%:p")

" space+. でvimrcを開く
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

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

" 新しいタブ
nnoremap st :<C-u>tabnew<CR>
" Unite
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" git-fugitive
nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>
nnoremap <silent> <Space>gs :Gstatus<CR>

" neoterm https://sy-base.com/myrobotics/vim/neovim-neoterm/
nnoremap <c-t><c-t> :Ttoggle<CR>
tnoremap <c-t><c-t> <C-¥><C-n>:Ttoggle<CR>


"<Leader>はバックスラッシュ

"検索ハイライトを消す
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

"ctagジャンプ Ctrl-hで横にCtrl-lで縦に分割
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-l> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" q: でも閉じる
map q: :q

"意味ないかも
let $PATH = "~/.pyenv/shims:".$PATH
" dein scripts-----------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " vim-gitgutter gitのHEADからのコード追加，削除，変更を左端に表示
  call dein#add('airblade/vim-gitgutter')

  " 括弧に色を付けるやつ
  call dein#add('luochen1990/rainbow')

  " ALE linter実行プラグイン　静的解析
  call dein#add('dense-analysis/ale')

  "sessionが保存されるらしい
  call dein#add('tpope/vim-obsession')

  "swiftのハイライト
  if has('mac')
    call dein#add('keith/swift.vim')
    call dein#add('landaire/deoplete-swift')
  endif

  call dein#load_toml('~/.config/nvim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/rc/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"End dein scripts -----------------------------------------------


"lightline
set laststatus=2
set showtabline=2
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline = { 'colorscheme': 'wombat' }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" TwitVim設定
let twitvim_enable_python = 1
let twitvim_browser_cmd = 'open'
let twitvim_force_ssl = 1
let twitvim_count = 40
let twitvim_filter_enable = 1

" Cheatsheet
let g:cheatsheet#cheat_file = '~/.cheatsheet.md'

function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

" Shift + F で自動修正
autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

filetype plugin indent on
syntax enable
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" dein.vimでのプラグイン削除, :call
" dein#recache_runtimepath()を実行すると良いらしい
call map(dein#check_clean(), "delete(v:val, 'rf')")

" 括弧に色つけるやつの設定
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


" Neco-look 設定
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

" powerline
let g:airline_powerline_fonts = 1
" colortheme
let g:airline_theme = 'papercolor'
" tabline
let g:airline#extensions#tabline#enabled = 1


""""""""ALE設定"""""""""""""""""""""""""""""""""""""""""""""""
" エラー行に表示するマーク
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" エラー表示の列を常時表示
let g:ale_sign_column_always = 1

" ファイルを開いたときにlint実行しない
let g:ale_lint_on_enter = 0
" ファイルを保存したときにlint実行
let g:ale_lint_on_save = 1
" 編集中のlintはしない
let g:ale_lint_on_text_changed = 'never'

" lint結果をロケーションリストとQuickFixには表示しない
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1

" 有効にするlinter
let g:ale_linters = {
\   'python': ['flake8'],
\   'cpp': ['clangd'],
\}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black', 'isort'],
  \ }
let g:ale_fix_on_save = 1

" 各ツールの実行オプションを変更してPythonパスを固定
" let g:ale_python_flake8_executable = g:python3_host_prog
" let g:ale_python_flake8_options = '-m flake8'
" let g:ale_python_isort_executable = g:python3_host_prog
" let g:ale_python_isort_options = '-m isort'
" let g:ale_python_black_executable = g:python3_host_prog
" let g:ale_python_black_options = '-m black'

" ALE用プレフィックス
nmap [ale] <Nop>
nmap <C-n> [ale]
" エラー行にジャンプ
nmap <silent> [ale]<C-p> <Plug>(ale_previous)
nmap <silent> [ale]<C-n> <Plug>(ale_next)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" vim-highlightedyank
let g:highlightedyank_highlight_duration = 300

" easymotion
" s{char}{char} to move to {char}{char}
map <leader>j <Plug>(easymotion-bd-f2)
nmap <leader>j <Plug>(easymotion-overwin-f2)

" Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)


"coc
" インストールされていなかったら起動時にインストール
" let g:coc_global_extensions = ['coc-pyls']

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
     \ pumvisible() ? "\<C-n>" :
     \ <SID>check_back_space() ? "\<TAB>" :
     \ coc#refresh()

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

autocmd FileType json syntax match Comment +\/\/.\+$+

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
""""""""""""""""""""""coc""""""""""""""""""""""""""""""""""""

" preview-markdown
nnoremap <space>md :PreviewMarkdown<CR>
let g:preview_markdown_vertical = 1
let g:preview_markdown_auto_update = 1
let g:preview_markdown_parser='glow'

"vim起動時にNERDTree起動
"autocmd VimEnter * execute 'NERDTree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" NERDTreeで隠しファイルも表示する
let NERDTreeShowHidden=1
" colorscheme
colorscheme wombat256mod

"カッコを閉じたとき対応するカッコに一時的に移動
set nostartofline
