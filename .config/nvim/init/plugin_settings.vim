scriptencoding utf-8

filetype plugin indent on
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" dein.vimでのプラグイン削除, :call
" dein#recache_runtimepath()を実行すると良いらしい
call map(dein#check_clean(), "delete(v:val, 'rf')")

" 括弧に色つけるやつの設定
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_liquid=1
let g:vim_markdown_math=0
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=0

set nofoldenable

" Copilot
let g:copilot_filetypes = {
      \ '*': 1,
      \ 'markdown': 1,
      \ 'yaml': 1,
      \ }

" open github link for dein toml
" ex. repo = 'neovim/nvim-lspconfig' => https://github.com/neovim/nvim-lspconfig
function! s:open_repository_from_toml() abort
  let github_domain = 'https://github.com/'
  let repo = getline('.')
  let repo = substitute(repo, 'repo =', '', '')
  let repo = substitute(repo, "\'", '', 'g')
  let repo = substitute(repo, '\"', '', 'g')
  let repo = substitute(repo, ' ', '', 'g')

  silent exec "!open '" . github_domain . repo . "'"
endfunction
nnoremap <silent> tt :call <SID>open_repository_from_toml()<CR>

" back to definition: <C-o> - jump to original window on list create.
nmap <silent> gp <C-o>


" tint.nvim
" lua <<EOF
"   require("tint").setup()
" EOF

" translate.vim
let g:translate_source = 'en'
let g:translate_target = 'ja'
let g:translate_popup_window = 1 " if you want use popup window, set value 1
let g:translate_winsize = 5 " set buffer window height size if you doesn't use popup window

nmap <space>t <Plug>(Translate)
vmap <space>t <Plug>(VTranslate)

let $BAT_THEME                     = 'gruvbox-dark'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox-dark'

" move.nvim
nnoremap <silent> <A-Down> :MoveLine(1)<CR>
nnoremap <silent> <A-Up> :MoveLine(-1)<CR>
vnoremap <silent> <A-Down> :MoveBlock(1)<CR>
vnoremap <silent> <A-Up> :MoveBlock(-1)<CR>

nnoremap <silent> <A-Right> :MoveHChar(1)<CR>
nnoremap <silent> <A-Left> :MoveHChar(-1)<CR>
vnoremap <silent> <A-Right> :MoveHBlock(1)<CR>
vnoremap <silent> <A-Left> :MoveHBlock(-1)<CR>


" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'man', 'startify', 'go']

function! s:myIndentGuideHighlight()
  highlight IndentGuidesOdd guibg=NONE
  highlight IndentGuidesEven guibg=green ctermbg=235
  " https://h2plus.biz/hiromitsu/entry/674
endfunction

augroup indentGuideHighlight
  autocmd!
  autocmd VimEnter,ColorScheme * call s:myIndentGuideHighlight()
augroup END

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

" directory to place notes and diaries.
let g:quick_notes_directory = '~/.cache/quick-notes/'
" suffix used for diaries
let g:quick_notes_suffix = 'md'

command! FzReadme call fzf#run(fzf#wrap(#{
          \ source: values(map(copy(dein#get()), {k,v-> k.' '.get(split(globpath(get(v,'dir',''), '\creadme.*'), '\n'), 0, '')})),
          \ options: ['--with-nth=1', '--preview', 'bat --color=always --plain {2}'],
          \ sink: funcref('s:DeinReadmeFzf')}))
function s:DeinReadmeFzf(name_and_path) abort
  execute 'DeinReadme' substitute(a:name_and_path, ' .*', '', '')
endfunction
