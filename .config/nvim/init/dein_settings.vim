scriptencoding utf-8

" lightline
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

" ===============================================
" ALE設定
" ===============================================
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
  \   'cpp': ['clang-format'],
  \ }
let g:ale_fix_on_save = 1

" 各ツールの実行オプションを変更してPythonパスを固定
" let g:ale_python_flake8_executable = g:python3_host_prog
" let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_flake8_use_global = 1
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

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_liquid=1
let g:vim_markdown_math=0
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=0

set nofoldenable



" ===============================================
" Coc
" ===============================================
" インストールされていなかったら起動時にインストール
let g:coc_global_extensions = ['coc-pyls', 'coc-python', 'coc-json', 'coc-pairs', 'coc-rls', 'coc-clangd', 'coc-tsserver', 'coc-prettier', 'coc-eslint']
" インストール先を固定するために必要
let g:coc_data_home = '~/'

autocmd FileType python let b:coc_root_patterns = ['pyproject.toml', '.git']
set sessionoptions+=globals

"coc-pairsのenterの挙動
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd FileType cpp let b:coc_pairs_disabled = ["<"]

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
" back to definition: <C-o> - jump to original window on list create.
nmap <silent> gp <C-o>

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

nmap <leader>d  :CocDiagnostic<CR>
nmap <silent>gk <Plug>(coc-diagnostic-prev)
nmap <silent>gj <Plug>(coc-diagnostic-next)


" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" ===============================================


" preview-markdown
nnoremap <space>md :PreviewMarkdown<CR>
let g:preview_markdown_vertical = 1
let g:preview_markdown_auto_update = 1
let g:preview_markdown_parser='glow'

" nnoremap <space>f :NERDTreeToggle<CR>
" NERDTreeで隠しファイルも表示する
" let NERDTreeShowHidden=1

" defx.nvim
nnoremap <space>f :Defx<CR>
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('open','tabnew')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('drop', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'explorer',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'mark:indent:icons:filename',
      \ 'post_action': 'jump',
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })

" 起動時に Defx 起動
" autocmd VimEnter * execute 'Defx'
" nnoremap <silent> <Leader>f :<C-u> Defx <CR>

" python file 起動時，Vista finder 起動
" autocmd BufNewFile,BufRead *.py execute 'Vista'

" translate.vim
let g:translate_source = "en"
let g:translate_target = "ja"
let g:translate_popup_window = 1 " if you want use popup window, set value 1
let g:translate_winsize = 5 " set buffer window height size if you doesn't use popup window

nmap <space>t <Plug>(Translate)
vmap <space>t <Plug>(VTranslate)

" telescope.nvim
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" git-fugitive
function! s:GstatusToggle() abort
  let found = 0
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitive'
      exe winnr . 'close'
      let found = 1
    endif
  endfor
  if !found
    Git
  endif
endfunction

nmap <space>gs :call <SID>GstatusToggle()<CR>

function! s:BlameToggle() abort
  let found = 0
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'fugitiveblame'
      exe winnr . 'close'
      let found = 1
    endif
  endfor
  if !found
    Git blame
  endif
endfunction

nmap <silent> <space>gb :call <SID>BlameToggle()<CR>
