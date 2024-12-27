local M = {}

function M.config()
	local function open_neoterm(cmd, option)
		-- local split = split_type()
		local command = option .. " " .. cmd
		vim.api.nvim_command(command)
	end

	vim.g.neoterm_autoinsert = 1
	vim.g.neoterm_autoscroll = 1
	vim.g.neoterm_size = tostring(0.4 * vim.o.lines)
	vim.g.neoterm_split_on_tnew = 1
	vim.keymap.set("n", "<C-t>", function()
		open_neoterm("Ttoggle", "bel")
	end, { noremap = true, silent = true })

	vim.keymap.set("t", "<C-t>", function()
		open_neoterm("Ttoggle", "bel")
	end, { silent = true })
end

return M
