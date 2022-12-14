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


-- null-ls

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup {
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.formatting_sync()
            end,
        })
    end
    local bufopts = { buffer = bufnr }
    vim.keymap.set('n', 'gk', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
  sources = {
    null_ls.builtins.diagnostics.textlint.with {
      filetypes = { 'markdown' },
      prefer_local = 'node_modules/.bin',
    },
    null_ls.builtins.formatting.textlint.with {
      filetypes = { 'markdown' },
      prefer_local = 'node_modules/.bin',
    },
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.black.with {
        filetypes = { 'python' },
        prefer_local = 'venv/bin',
    },
    null_ls.builtins.formatting.gofumpt,
  },
}
