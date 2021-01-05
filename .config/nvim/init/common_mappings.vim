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

" コマンドラインモードで履歴を探索
cnoremap <C-p> <Up>

" 0 で(インデントを含む|含まない)行頭をtoggleで移動できる
noremap <expr> 0 getline('.')[0 : col('.') - 2] =~# '^\s\+$' ? '0' : '^'

"<Leader>はバックスラッシュ

"検索ハイライトを消す
nnoremap  <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

"ctagジャンプ Ctrl-hで横にCtrl-lで縦に分割
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-l> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

" q: でも閉じる
map q: :q

command Tmux e ~/.tmux_cheatsheet.md
command Work e ~/.work_cheatsheet.md
command Cheat e ~/.vim_cheatsheet.md
command Shell e ~/.shell_cheatsheet.md
command Prog e ~/.prog_cheatsheet.md
command Goal e ~/.goal_cheatsheet.md
command Todo e ~/.todo_cheatsheet.md
command Refresh :call dein#recache_runtimepath()
command Path echo expand("%:p")
