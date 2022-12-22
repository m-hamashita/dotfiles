local M = {}

function M.config()
	vim.api.nvim_set_keymap("n", "<C-p>", ":<C-u>Deol -split=floating<CR>", {

		noremap = true,
		silent = true,
	})
end

return M
