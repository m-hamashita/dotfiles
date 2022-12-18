local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require('lsp-inlayhints').setup {}

if vim.fn.has('nvim-0.8') == 1 then
  local lsp_augroup = augroup('LSP_preferences', { clear = true })
  autocmd('LspAttach', {
    group = lsp_augroup,
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- Start lsp-inlayhints to display virtual text hints for function return
      -- types, parameter names, etc.
      require('lsp-inlayhints').on_attach(client, bufnr)

      -- Show code lenses including, for example, imported symbols for blanket
      -- import lines in Haskell modules. This also enables code lens actions.
      -- Code lenses don't show up unless the `refresh` function is called.
      --
      -- Code lenses are not directly related to inlay hints, and code lenses do
      -- not use the lsp-inlayhints plugin. But it is convenient to put this
      -- configuration here.
      if client.server_capabilities.codeLensProvider then
        autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
          group = lsp_augroup,
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end
    end,
  })
end

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
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --         vim.lsp.buf.format({ bufnr = bufnr })
        --     end,
        -- })
    end
    local bufopts = { buffer = bufnr }
    vim.keymap.set('n', 'gk', function()
      vim.lsp.buf.format { async = true }
    end, bufopts)
  end,
  sources = {
    null_ls.builtins.diagnostics.textlint.with {
      filetypes = { 'markdown' },
    },
    null_ls.builtins.formatting.textlint.with {
      filetypes = { 'markdown' },
    },
    null_ls.builtins.formatting.prettier.with {
      filetypes = { 'javascript', 'typescript', 'json', 'yaml', 'markdown', 'graphql'},
    },
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.black.with {
        filetypes = { 'python' },
        prefer_local = 'venv/bin',
    },
    null_ls.builtins.formatting.gofumpt,
    -- null_ls.builtins.formatting.rustfmt,
  },
}

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})
