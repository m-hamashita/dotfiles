scriptencoding utf-8

" x で削除した時にコピーしない
noremap x "_x

nnoremap s <Nop>
nnoremap sj <C-w>j "タブ移動系
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h

" noremap <S-h>   ^ "カーソル移動系shift+hjkl
" noremap <S-j>   }
" noremap <S-k>   {
" noremap <S-l>   $
noremap <S-j> <Nop>

" 使わないので無効化
nnoremap Q <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

tnoremap <silent><ESC> <C-\><C-n>

" ctags
augroup pythonJumpDefinition
  autocmd!
  autocmd FileType python nnoremap <C-]> g<C-]>
  autocmd FileType python inoremap <C-]> <ESC>g<C-]>
  autocmd FileType python nnoremap <silent><C-[> <C-t>
augroup end

" vim-go
augroup goJumpDefinition
  autocmd!
  autocmd FileType go nmap <silent> gi <Plug>(go-implements)
  autocmd FileType go nmap <silent> rf <Plug>(go-referrers)
  autocmd FileType go nnoremap <silent> <C-[> :GoDefPop<CR>
  autocmd FileType go nmap <leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <leader>v <Plug>(go-def-vertical)
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
inoremap <silent> jj <ESC>
" normal mode 時保存
" :<C-u>w<CR>

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
" nnoremap <silent> <Space>gb :Gblame<CR>
nnoremap <silent> <Space>gd :Gdiff<CR>
" nnoremap <silent> <Space>gs :Gstatus<CR>
nnoremap <silent> <space>ga :Gwrite<CR>
nnoremap <silent> <space>gc :Git commit<CR>

" neoterm https://sy-base.com/myrobotics/vim/neovim-neoterm/
nnoremap <c-t><c-t> :Ttoggle<CR>
tnoremap <c-t><c-t> <C-¥><C-n>:Ttoggle<CR>
nnoremap <c-t><c-n> :Tnew<CR>

" コマンドラインモードで履歴を探索
cnoremap <C-p> <Up>

" 0 で(インデントを含む|含まない)行頭をtoggleで移動できる
noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'

"<Leader>はバックスラッシュ

"検索ハイライトを消す
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

"ctagジャンプ Ctrl-hで横にCtrl-lで縦に分割
" nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
" nnoremap <C-l> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

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

command Tmux e ~/.tmux_cheatsheet.md
command Work e ~/.work_cheatsheet.md
command Cheat e ~/.vim_cheatsheet.md
command Shell e ~/.shell_cheatsheet.md
command Prog e ~/.prog_cheatsheet.md
command Goal e ~/.goal_cheatsheet.md
command Todo e ~/.todo_cheatsheet.md
command Refresh :call dein#recache_runtimepath()
command Path echo expand("%:p")
command Memo call QuickNotesNew()
command MemoFzf call QuickNotesFzf()
