local M = {}

function M.config()
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local null_ls = require("null-ls")
	null_ls.setup({
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
			local bufopts = { buffer = bufnr }
			vim.keymap.set("n", "gk", function()
				vim.lsp.buf.format({ async = true })
			end, bufopts)
		end,
		sources = {
			null_ls.builtins.diagnostics.textlint.with({
				filetypes = { "markdown" },
			}),
			null_ls.builtins.formatting.textlint.with({
				filetypes = { "markdown" },
			}),
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "javascript", "typescript", "json", "yaml", "markdown", "graphql" },
			}),
			null_ls.builtins.formatting.yamlfmt,
			null_ls.builtins.formatting.black.with({
				filetypes = { "python" },
				prefer_local = "venv/bin",
			}),
			null_ls.builtins.formatting.gofumpt,
			null_ls.builtins.formatting.stylua.with({
				filetypes = { "lua" },
				-- args = { '--config-path', vim.fn.stdpath('config') .. '/stylua.toml' },
			}),
			-- null_ls.builtins.formatting.rustfmt,
		},
	})
end

return M
