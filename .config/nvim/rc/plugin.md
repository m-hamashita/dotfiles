# ここにインストールしたpluginとその説明を記述する
## 使ってるやつ
### 括弧とかいい感じに補完するやつ
" call dein#add('cohama/lexima.vim')

### vim上でterminalが開ける
[[plugins]]
repo = 'Shougo/deol.nvim'
" 【Ctrl + o】 float windowでターミナルを表示
nnoremap <silent><C-o> :<C-u>Deol -split=floating<CR>
" ターミナルモードから抜ける
tnoremap <silent>jj  <C-\><C-n>

### vim-fugitive Gitクライアントプラグイン
" vimから離れずにGitが使える toml
" call dein#add('tpope/vim-fugitive')

### ディレクトリをツリー表示とショートカットCtrl+eで開く
call dein#add('scrooloose/nerdtree')
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
