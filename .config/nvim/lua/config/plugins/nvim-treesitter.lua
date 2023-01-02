local M = {}

function M.config()
	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
		},
		ensure_installed = {
			"go",
			"python",
			"lua",
			"yaml",
			"json",
			"bash",
			"latex",
			"fish",
			"gomod",
			"html",
			"toml",
			"vim",
			"ruby",
			"c",
			"cpp",
			"c_sharp",
			"comment",
			"jsonc",
			"javascript",
			"cuda",
			"scala",
			"dockerfile",
			"rust",
			"query",
			"julia",
			"lua",
		},
		indent = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	})
end

return M
