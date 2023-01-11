local M = {}

function M.config()
	local status_ok, rt = pcall(require, "rust-tools")
	if not status_ok then
		return
	end
	local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not cmp_nvim_lsp_status then
		return
	end
	-- used to enable autocompletion (assign to every lsp server config)
	local capabilities = cmp_nvim_lsp.default_capabilities()
	local on_attach = function(client, bufnr)
		-- keybind options
		local opts = { noremap = true, silent = true, buffer = bufnr }
		-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- set keybinds
		vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		-- Hover actions
		vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
		-- Code action groups
		vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
	end
	local opts = {
		tools = {
			executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
			reload_workspace_from_cargo_toml = true,
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = "  ",
				other_hints_prefix = "  ",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 7,
				highlight = "Comment",
			},
			hover_actions = {
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},
				auto_focus = true,
			},
		},
		server = {
			on_attach = on_attach,
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		},
	}
	rt.setup(opts)
end

return M
