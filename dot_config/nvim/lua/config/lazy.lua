if vim.loader then
	vim.loader.enable()
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
	-- colorscheme
	{ "vim-scripts/wombat256.vim" },
	{ "sainnhe/everforest" },
	{ "franbach/miramare" },
	{ "jnurmine/Zenburn" },
	{ "ghifarit53/tokyonight-vim" },
	{ "novasenco/vulpo" },
	{ "raphamorim/lucario" },
	{ "bluz71/vim-moonfly-colors" },
	{ "sonph/onehalf" },
	{ "savq/melange" },
	{ "kyoh86/momiji" },
	{ "rebelot/kanagawa.nvim" },
	{ "tobi-wan-kenobi/zengarden" },
	{ "AlessandroYorba/Alduin" },
	{ "ayu-theme/ayu-vim" },
	{ "glepnir/zephyr-nvim" },
	{ "sainnhe/edge" },
	{ "npxbr/gruvbox.nvim" },
	{ "sainnhe/sonokai" },
	{
		"elianiva/gruvy.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},
	{ "sainnhe/gruvbox-material", lazy = false },
	{
		"machakann/vim-highlightedyank",
		event = "VeryLazy",
		config = require("config.plugins.vim-highlightedyank").config(),
	},
	-- plugins
	{
		-- file explorer
		"lambdalisue/fern.vim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.fern").config()
		end,
		dependencies = {
			"lambdalisue/nerdfont.vim",
			"lambdalisue/fern-renderer-nerdfont.vim",
			"lambdalisue/glyph-palette.vim",
			"lambdalisue/fern-git-status.vim",
		},
	},
	{
		"skanehira/denops-germanium.vim",
		event = "VeryLazy",
		dependencies = {
			"vim-denops/denops.vim",
		},
	},
	{ "machakann/vim-sandwich", event = "VeryLazy" },
	{ "tpope/vim-surround", event = "VeryLazy" },
	{
		"gelguy/wilder.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.wilder").config()
		end,
	},
	{
		"Shougo/deol.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.deol").config()
		end,
	},
	{ "williamboman/mason.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.plugins.mason").config()
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.none-ls").config()
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("config.plugins.mason-null-ls").config()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("config.plugins.mason-tool-installer").config()
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.lsp-inlayhints").config()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		config = function()
			require("config.plugins.nvim-cmp").config()
		end,
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/vim-vsnip" },
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("config.plugins.lspsaga").config()
		end,
	},
	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.lualine").config()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		config = function()
			require("config.plugins.indent-blankline").config()
		end,
	},
	{ "kyazdani42/nvim-web-devicons", event = "VeryLazy" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		},
		config = function()
			require("config.plugins.telescope").config()
		end,
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{ "tpope/vim-rhubarb", event = "VeryLazy" },
	{ "tpope/vim-fugitive", event = "VeryLazy" },
	{ "airblade/vim-gitgutter", event = "VeryLazy" },
	-- {
	--     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	--     event = "VeryLazy",
	--     config = function()
	--         require("config.plugins.lsp_lines").config()
	--     end,
	--     dependencies = { "neovim/nvim-lspconfig" },
	-- },
	{ "vijaymarupudi/nvim-fzf", event = "VeryLazy" },
	{ "vim-denops/denops.vim", event = "VeryLazy" },
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("config.plugins.nvim-treesitter").config()
		end,
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{
		"kassio/neoterm",
		event = "VeryLazy",
		config = function()
			require("config.plugins.neoterm").config()
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.comment").config()
		end,
	},
	{ "sindrets/diffview.nvim", event = "VeryLazy" },
	{ "plasticboy/vim-markdown", event = "VeryLazy" },
	{ "hashivim/vim-terraform", event = "VeryLazy" },
	{ "dag/vim-fish", event = "VeryLazy" },
	{ "skanehira/getpr.vim", event = "VeryLazy" },
	{
		"luochen1990/rainbow",
		event = "VeryLazy",
		config = function()
			require("config.plugins.rainbow").config()
		end,
	},
	{
		"notomo/reacher.nvim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.reacher").config()
		end,
	},
	{
		"eiji03aero/quick-notes",
		event = "VeryLazy",
		config = function()
			require("config.plugins.quick-notes").config()
		end,
	},
	{
		"simeji/winresizer",
		event = "VeryLazy",
		config = function()
			require("config.plugins.winresizer").config()
		end,
	},
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
		config = function()
			require("config.plugins.conflict-marker").config()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.plugins.todo-comments").config()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("config.plugins.noice").config()
		end,
	},
	{
		"tversteeg/registers.nvim",
		name = "registers",
		config = function()
			require("config.plugins.registers").config()
		end,
		cmd = "Registers",
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			provider = "openai",
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
				temperature = 0,
				max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			},
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		event = "VeryLazy",
		tag = "v1.6.1",
		config = function()
			require("config.plugins.fidget").config()
		end,
	},
}, {
	defaults = { lazy = true },
	-- debug = true,
})
