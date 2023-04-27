local M = {}

M.config = function()
	local status_ok, rust_tools = pcall(require, "rust-tools")
	if not status_ok then
		return
	end
	local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not cmp_nvim_lsp_status then
		return
	end
	-- used to enable autocompletion (assign to every lsp server config)
	-- local capabilities = cmp_nvim_lsp.default_capabilities()

	local on_attach = function(_, bufnr)
		-- keybind options
		local opts = { noremap = true, silent = true, buffer = bufnr }
		-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		-- set keybinds
		vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		-- Hover actions
		vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
		-- Code action groups
		vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
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
	local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/")
	local vscode_path = vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.8.1/"

	local path = ""
	local debugger_found = true
	if M.dir_exists(mason_path) then
		path = mason_path
	elseif M.dir_exists(vscode_path) then
		path = vscode_path
	else
		debugger_found = false
		vim.notify("please install codelldb using :Mason or via vscode", vim.log.levels.WARN)
	end

	if debugger_found then
		local codelldb_path = path .. "adapter/codelldb"
		local liblldb_path = path .. "lldb/lib/liblldb.so"

		if vim.fn.has("mac") == 1 then
			liblldb_path = path .. "lldb/lib/liblldb.dylib"
		end

		if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
			opts.dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			}
		else
			vim.notify("please reinstall codellb, i cannot find liblldb or codelldb itself", vim.log.levels.WARN)
		end
	end
	rust_tools.setup(opts)
end

M.dir_exists = function(file)
	local ok, _, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok
end

return M
