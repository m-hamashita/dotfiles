local M = {}

function M.config()
	vim.g["fern#renderer"] = "nerdfont"
	vim.g["fern#default_hidden"] = 1
	vim.api.nvim_set_keymap("n", "<space>w", ":<C-u>Fern . -drawer -toggle<CR>", {
		noremap = true,
		silent = true,
	})

	vim.cmd([[
	    augroup glyph-palette
	      autocmd! *
	      autocmd FileType fern call glyph_palette#apply()
	      autocmd FileType nerdtree,startify call glyph_palette#apply()
	    augroup END
    ]])
end

return M
