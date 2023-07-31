scriptencoding utf-8

" x で削除した時にコピーしない
nnoremap x "_x

nnoremap s <Nop>
nnoremap sj <C-w>j "タブ移動系
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

" カーソル移動系shift+hjkl
noremap <S-h>   ^
" noremap <S-j>   }
" noremap <S-k>   {
noremap <S-l>   $
noremap <S-j> <Nop>

inoremap <C-x> <Nop>

" 使わないので無効化
nnoremap Q <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" buffer 移動
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" terminal mode の ESC
tnoremap <silent><ESC> <C-\><C-n>

" 検索時の移動
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" ctags
augroup pythonJumpDefinition
  autocmd!
  autocmd FileType python nnoremap <C-]> g<C-]>
  autocmd FileType python inoremap <C-]> <ESC>g<C-]>
  autocmd FileType python nnoremap <silent><C-[> <C-t>
augroup end


augroup quickfixAutocmd
  autocmd!
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>:lclose<CR>
augroup end

" nnoremap <silent> lo :lopen<CR>
" nnoremap <silent> lc :lclose<CR>

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


" git-fugitive
" nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>
" nnoremap <silent> <Space>gs :Gstatus<CR>
nnoremap <silent> <space>ga :Gwrite<CR>
nnoremap <silent> <space>gc :Git commit<CR>

" コマンドラインモードで履歴を探索
cnoremap <C-p> <Up>

" 0 で(インデントを含む|含まない)行頭をtoggleで移動できる
noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'

" <Leader> の default はバックスラッシュ
" let mapleader = "\<space>" " space に変更

" 検索ハイライトを消す
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" q: でも閉じる
map q: :q

" Toggle quickfix
if exists('g:__QUICKFIX_TOGGLE__')
    finish
endif
let g:__QUICKFIX_TOGGLE__ = 1

function! ToggleQuickfix()
    let l:nr = winnr('$')
    cwindow
    let l:nr2 = winnr('$')
    if l:nr == l:nr2
        cclose
    endif
endfunction
nnoremap <script> <silent> <Space>c :call ToggleQuickfix()<CR>

cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's'

command Refresh :call dein#recache_runtimepath()
command Path echo expand("%:p")
command Memo call QuickNotesNew()
command MemoFzf call QuickNotesFzf()
