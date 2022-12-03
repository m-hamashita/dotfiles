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
