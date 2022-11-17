" インストールされていなかったら起動時にインストール
let g:coc_global_extensions = ['coc-json', 'coc-pairs', 'coc-clangd', 'coc-tsserver', 'coc-prettier', 'coc-eslint', 'coc-yaml', 'coc-git', 'coc-fzf-preview', 'coc-docker', 'coc-pyright', 'coc-go', 'coc-rust-analyzer']
" RUN :CocCommand go.install.gopls
" インストール先を固定するために必要
" let g:coc_data_home = '~/'

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap gw <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

augroup cocRootPattern
  autocmd!
  autocmd FileType python let b:coc_root_patterns = ['pyproject.toml', '.git']
augroup END
set sessionoptions+=globals

"coc-pairsのenterの挙動
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
augroup cocPairsSettings
  autocmd!
  autocmd FileType cpp let b:coc_pairs_disabled = ["<"]
augroup END

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~? '\s'
endfunction
inoremap <silent><expr> <TAB>
     \ pumvisible() ? "\<C-n>" :
     \ <SID>check_back_space() ? "\<TAB>" :
     \ coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
augroup cocCursorHold
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

augroup cocJson
  autocmd!
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

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

nnoremap <silent> <C-p>  :<C-u>CocCommand fzf-preview.FromResources buffer project_mru project<CR>
nnoremap <silent> [ff]s  :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [ff]gg :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [ff]b  :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap          [ff]f  :<C-u>CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>
xnoremap          [ff]f  "sy:CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

nnoremap <silent> [ff]q  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> [ff]rf :<C-u>CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> [ff]d  :<C-u>CocCommand fzf-preview.CocDefinition<CR>
nnoremap <silent> [ff]t  :<C-u>CocCommand fzf-preview.CocTypeDefinition<CR>
nnoremap <silent> [ff]o  :<C-u>CocCommand fzf-preview.CocOutline --add-fzf-arg=--exact --add-fzf-arg=--no-sort<CR>
