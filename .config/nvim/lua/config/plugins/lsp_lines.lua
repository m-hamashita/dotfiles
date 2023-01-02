local M = {}

function M.config()
	local status_ok, lsp_lines = pcall(require, "lsp_lines")
	if not status_ok then
		return
	end

	lsp_lines.setup({})

	vim.diagnostic.config({
		virtual_text = false,
	})

	vim.keymap.set("n", "<leader><leader>", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
end

return M
