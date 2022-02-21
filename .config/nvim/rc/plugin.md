# ここにインストールした plugin とその説明を記述する

## 使ってるやつ

### vim 上で terminal が開ける

[[plugins]]
repo = 'Shougo/deol.nvim'
" 【Ctrl + o】 float window でターミナルを表示
nnoremap <silent><C-o> :<C-u>Deol -split=floating<CR>

### vim-fugitive Git クライアントプラグイン

" vim から離れずに Git が使える toml
" call dein#add('tpope/vim-fugitive')

### ディレクトリをツリー表示とショートカット Ctrl+e で開く

call dein#add('scrooloose/nerdtree')

### caw.vim

" コメントアウトが簡単にできる
[[plugins]]
repo = "tyru/caw.vim.git"
on_i = 1
hook_add = '''
nmap c <Plug>(caw:hatpos:toggle)
vmap c <Plug>(caw:hatpos:toggle)
nmap , <Plug>(caw:zeropos:toggle)
vmap , <Plug>(caw:zeropos:toggle)
'''

## 使ってないやつ

### deolate の設定

let g:deoplete#enable_at_startup = 1
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-clang')
if !has('nvim')
call dein#add('roxma/nvim-yarp')
call dein#add('roxma/vim-hug-neovim-rpc')
endif

### Twitvim

" call dein#add('~/.vim/local_repos/twitvim/twitvim')
"Twitvim Refresh
nnoremap <Leader>q :<C-u>RefreshTwitter<CR>

### 括弧とかいい感じに補完するやつ

" call dein#add('cohama/lexima.vim')

### defx.nvim

- brew tap homebrew/cask-fonts
- brew cask install font-hack-nerd-font

### denops.vim

- deno をインストールする必要あり
  - ex. brew install deno
