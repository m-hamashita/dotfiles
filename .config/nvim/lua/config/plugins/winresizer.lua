local M = {}

function M.config()
	vim.keymap.set("n", "<C-w>", ":WinResizerStartResize<CR>")
	vim.g.winresizer_enable = 1
	vim.g.winresizer_start_key = ""
	vim.g.winresizer_vert_resize = 1
	vim.g.winresizer_horiz_resize = 1
end

return M
