scriptencoding utf-8

filetype plugin indent on
syntax enable

" gundo
nmap U :<C-u>GundoToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" dein.vimでのプラグイン削除, :call
" dein#recache_runtimepath()を実行すると良いらしい
call map(dein#check_clean(), "delete(v:val, 'rf')")

" 括弧に色つけるやつの設定
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle


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
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

" 有効にするlinter
let g:ale_linters = {
  \   'python': ['flake8', 'mypy'],
  \   'cpp': ['clangd'],
  \   'vim': ['vint'],
  \   'rust': [],
  \}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'python': ['black', 'isort'],
  \   'cpp': ['clang-format'],
  \   'go': ['goimports'],
  \ }
let g:ale_fix_on_save = 1

" 各ツールの実行オプションを変更してPythonパスを固定
let g:ale_python_flake8_executable = g:pip_command_path . 'flake8'
" let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_flake8_use_global = 1
let g:ale_python_mypy_executable = g:pip_command_path . 'mypy'
" let g:ale_python_mypy_options = '-m mypy'
let g:ale_python_isort_executable = g:pip_command_path . 'isort'
let g:ale_python_isort_options = '--line-length=110 --ensure-newline-before-comments --force-grid-wrap=0 --trailing-comma --multi-line=3 --use-parentheses'
let g:ale_python_black_executable = g:pip_command_path . 'black'
let g:ale_python_black_options = '-t py310 --line-length=110'
let g:ale_list_window_size = 5


" ALE用プレフィックス
nmap [ale] <Nop>
nmap <C-n> [ale]
" エラー行にジャンプ
nmap <silent> [ale]<C-p> <Plug>(ale_previous)
nmap <silent> [ale]<C-n> <Plug>(ale_next)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" ===============================================
" Coc
" ===============================================
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

" ===============================================

" defx.nvim
if !exists('g:vscode')
    nnoremap <space>f :Defx<CR>
    augroup defxSettings
      autocmd!
      autocmd FileType defx call s:defx_my_settings()
      " 起動時に Defx 起動
      " autocmd VimEnter * execute 'Defx'
      " nnoremap <silent> <Leader>f :<C-u> Defx <CR>
    augroup END

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

    " gelguy/wilder.nvim
    " Key bindings can be changed, see below
    autocmd CmdlineEnter * ++once call s:wilder_init() | call wilder#main#start()
    function! s:wilder_init() abort
      call wilder#setup({
            \ 'modes': [':', '/', '?'],
            \ 'next_key': '<C-n>',
            \ 'previous_key': '<C-p>',
            \ })
      call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline({
            \       'fuzzy': 1,
            \     }),
            \     wilder#python_search_pipeline({
            \       'pattern': 'fuzzy',
            \     }),
            \   ),
            \ ])
      call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
            \ 'highlights': {
            \    'border': 'Normal',
            \ },
            \ 'highlighter': wilder#basic_highlighter(),
            \ 'min_width': '10%',
            \ 'max_width': '20%',
            \ 'max_height': '15%',
            \ 'reverse': 0,
            \ 'left': [
            \   ' ', wilder#popupmenu_devicons(),
            \ ],
            \ 'right': [
            \   ' ', wilder#popupmenu_scrollbar(),
            \ ],
            \ 'border': 'rounded',
            \ })))
    endfunction
endif


" rnvimr plugin
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
let g:rnvimr_enable_picker = 1

let g:rnvimr_layout = {
            \ 'relative': 'editor',
            \ 'width': float2nr(round(0.9 * &columns)),
            \ 'height': float2nr(round(0.9 * &lines)),
            \ 'col': float2nr(round(0.05 * &columns)),
            \ 'row': float2nr(round(0.05 * &lines)),
            \ 'style': 'minimal'
            \ }

" nvim-treesitter
if !exists('g:vscode')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  ensure_installed = {"go", "python", "lua", "yaml", "json",  "bash", "latex", "fish", "gomod", "html", "toml", "vim", "ruby", "c", "cpp", "c_sharp", "comment", "jsonc", "javascript", "cuda", "scala", "dockerfile", "rust", "query", "julia", "lua"},
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF
endif

" nvim-lspconfig
lua <<EOF
  -- -- Mappings.
  -- -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  -- local opts = { noremap=true, silent=true }
  -- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- -- Use an on_attach function to only map the following keys
  -- -- after the language server attaches to the current buffer
  -- local on_attach = function(client, bufnr)
  --   -- Enable completion triggered by <c-x><c-o>
  --   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --   -- Mappings.
  --   -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- local bufopts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  --   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  --   vim.keymap.set('n', '<space>wl', function()
  --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --   end, bufopts)
  --   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  --   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  --   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  --   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --   vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  -- end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }
  -- nvim-navic
  local navic = require("nvim-navic")
  require("lspconfig").clangd.setup {
      on_attach = function(client, bufnr)
          navic.attach(client, bufnr)
      end
  }
  -- require("lspconfig").rust_analyzer.setup {
  --     on_attach = on_attach,
  --     flags = lsp_flags,
  -- }
  -- :LspInstall gopls
  -- :LspInstall pyright
  -- require("lspconfig").gopls.setup {}
  -- require("lspconfig").pyright.setup {}
EOF

" tint.nvim
" lua <<EOF
"   require("tint").setup()
" EOF

" reacher.nvim
lua <<EOF
  -- search in the current window
  vim.keymap.set({ "n", "x" }, "gs", [[<Cmd>lua require("reacher").start()<CR>]])

  -- search in the all windows in the current tab
  vim.keymap.set({ "n", "x" }, "gS", [[<Cmd>lua require("reacher").start_multiple()<CR>]])

  -- search in the current line
  vim.keymap.set({ "n", "x" }, "gl", function()
    require("reacher").start({
      first_row = vim.fn.line("."),
      last_row = vim.fn.line("."),
    })
  end)

  local group = "reacher_setting"
  vim.api.nvim_create_augroup(group, {})
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "reacher" },
    callback = function()
      vim.keymap.set({ "n", "i" }, "<CR>", [[<Cmd>lua require("reacher").finish()<CR>]], { buffer = true })
      vim.keymap.set({ "n", "i" }, "<ESC>", [[<Cmd>lua require("reacher").cancel()<CR>]], { buffer = true })

      vim.keymap.set("n", "gg", [[<Cmd>lua require("reacher").first()<CR>]], { buffer = true })
      vim.keymap.set("n", "G", [[<Cmd>lua require("reacher").last()<CR>]], { buffer = true })

      vim.keymap.set({ "n", "i" }, "<C-n>", [[<Cmd>lua require("reacher").next()<CR>]], { buffer = true })
      vim.keymap.set({ "n", "i" }, "<C-p>", [[<Cmd>lua require("reacher").previous()<CR>]], { buffer = true })
      vim.keymap.set("i", "<Down>", [[<Cmd>lua require("reacher").next()<CR>]], { buffer = true })
      vim.keymap.set("i", "<Up>", [[<Cmd>lua require("reacher").previous()<CR>]], { buffer = true })
    end,
  })
EOF

" indent-blankline.nvim"
lua <<EOF
  vim.opt.list = true
  require("indent_blankline").setup {
    show_current_context = true,
  }
EOF

" translate.vim
let g:translate_source = 'en'
let g:translate_target = 'ja'
let g:translate_popup_window = 1 " if you want use popup window, set value 1
let g:translate_winsize = 5 " set buffer window height size if you doesn't use popup window

nmap <space>t <Plug>(Translate)
vmap <space>t <Plug>(VTranslate)

" TODO: 現状 Telescope と fzf-preview の mapping が重複している
" telescope.nvim
lua <<EOF
  require('telescope').load_extension('cder')
  require('telescope').setup({
    extensions = {
      cder = {
        dir_command = { 'fd', '--type=d', '.', os.getenv('HOME'), 'Documents/work' },
        previewer_command =
          'exa '..
          '-a '..
          '--color=always '..
          '-T '..
          '--level=3 '..
          '--icons '..
          '--git-ignore '..
          '--long '..
          '--no-permissions '..
          '--no-user '..
          '--no-filesize '..
          '--git '..
          '--ignore-glob=.git',
      },
    },
  })
EOF
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>gg <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>Telescope cder<cr>

" fzf-preview
nmap <leader>f [ff]
xmap <leader>f [ff]

let $BAT_THEME                     = 'gruvbox-dark'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'gruvbox-dark'

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
