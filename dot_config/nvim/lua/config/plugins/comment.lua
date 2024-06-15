local M = {}

function M.config()
	require("Comment").setup({
		toggler = {
			line = ",",
		},
		opleader = {
			line = ",",
		},
		mappings = {
			basic = true,
			extra = true,
		},
	})
end

return M
