lua << END
-- local cmp = require'cmp'
--
-- local lspconfig = require'lspconfig'
-- cmp.setup({
--   snippet = {
--     -- REQUIRED by nvim-cmp. get rid of it once we can
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
--     { name = 'nvim_lsp' },
--   }, {
--     { name = 'path' },
--   }),
--   experimental = {
--     ghost_text = true,
--   },
-- })
--
-- -- Enable completing paths in :
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   })
-- })
--
-- -- Setup lspconfig.
-- local on_attach = function(client, bufnr)
--   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
--
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
--
--   -- Mappings.
--   local opts = { noremap=true, silent=true }
--
--   -- See `:help vim.lsp.*` for documentation on any of the below functions
--   buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
--   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--
--   -- Get signatures (and _only_ signatures) when in argument lists.
--   require "lsp_signature".on_attach({
--     doc_lines = 0,
--     handler_opts = {
--       border = "none"
--     },
--   })
-- end
--
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   flags = {
--     debounce_text_changes = 150,
--   },
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--       completion = {
--         postfix = {
--           enable = false,
--         },
--       },
--     },
--   },
--   capabilities = capabilities,
-- }
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )



-- mason
local mason = require('mason')
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
local nvim_lsp = require('lspconfig')
local lspconfig = require('mason-lspconfig')
lspconfig.setup_handlers({ function(server_name)
  local opts = {}
  opts.on_attach = function(_, bufnr)
    local bufopts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>p', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  end
  nvim_lsp[server_name].setup(opts)
end })


-- rust-tools
-- local rust_opts = {
--   tools = {
--     executor = require("rust-tools/executors").termopen,
--     on_initialized = nil,
--     reload_workspace_from_cargo_toml = true,
--     inlay_hits = {
--       auto = true,
--       only_current_line = false,
--       show_parameter_hints = true,
--       parameter_hints_prefix = "",
--       other_hints_prefix = "",
--       max_len_align = false,
--       right_align = false,
--       highlight = "Comment",
--     },
--     hover_actions = {
--       border = {
--         { "╭", "FloatBorder" },
--         { "─", "FloatBorder" },
--         { "╮", "FloatBorder" },
--         { "│", "FloatBorder" },
--         { "╯", "FloatBorder" },
--         { "─", "FloatBorder" },
--         { "╰", "FloatBorder" },
--         { "│", "FloatBorder" },
--       },
--       auto_focus = false,
--     },
--   },
--   server = {
--     standalone = true,
--     capabilities = capabilities,
--     on_attach = function(_, bufnr)
--       require('rust-tools').inlay_hints.set()
--       require('rust-tools').inlay_hints.enable()
--       on_attach(_, bufnr)
--     end,
--     settings = {
--       cmd = {"rustup run stable rust-analyzer"},
--       ['rust-analyzer'] = {
--         lens = {
--           enable = true,
--         },
--         checkonsave = {
--           command = 'clippy'
--         },
--       },
--     },
--   },
--   dap = {
--     adaptor = {
--       type = "exectuable",
--       command = "lldb-vscode",
--       name = "rt_lldb"
--     }
--   }
-- }
-- require('rust-tools').setup(rust_opts)

-- local rt = require("rust-tools")
--
-- rt.setup({
--   server = {
--     on_attach = function(_, bufnr)
--       -- Hover actions
--       vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--       -- Code action groups
--       vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
-- })
-- -- Set inlay hints for the current buffer
-- require('rust-tools').inlay_hints.set()
--
-- -- Enable inlay hints auto update and set them for all the buffers
-- require('rust-tools').inlay_hints.enable()
END




" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
