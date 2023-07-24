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
		event = "UIEnter",
		config = require("config.plugins.vim-highlightedyank").config(),
	},
	{
		-- file explorer
		"lambdalisue/fern.vim",
		event = "UIEnter",
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
	{ "machakann/vim-sandwich", event = "UIEnter" },
	{ "tpope/vim-surround", event = "UIEnter" },
	{
		"gelguy/wilder.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.wilder").config()
		end,
	},
	{
		-- support open new tab
		"lambdalisue/guise.vim",
		event = "UIEnter",
		dependencies = {
			"vim-denops/denops.vim",
		},
	},
	{
		"Shougo/deol.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.deol").config()
		end,
	},
	{ "williamboman/mason.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		event = "VeryLazy",
		config = function()
			require("config.plugins.mason").config()
		end,
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
	},
	{
		"github/copilot.vim",
		event = "UIEnter",
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("config.plugins.copilot").config()
	-- 		end, 100)
	-- 	end,
	-- },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	after = { "zbirenbaum/copilot.lua" },
	-- },
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.null-ls").config()
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.lsp-inlayhints").config()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "UIEnter",
		config = function()
			require("config.plugins.nvim-cmp").config()
		end,
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/vim-vsnip" },
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.lualine").config()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("config.plugins.rust-tools").config()
		end,
	},
	{ "kyazdani42/nvim-web-devicons", event = "UIEnter" },
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
	{ "dstein64/vim-startuptime", event = "UIEnter" },
	{ "tpope/vim-rhubarb", event = "UIEnter" },
	{ "tpope/vim-fugitive", event = "UIEnter" },
	{ "airblade/vim-gitgutter", event = "UIEnter" },
	{
		"Maan2003/lsp_lines.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.lsp_lines").config()
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{ "vijaymarupudi/nvim-fzf", event = "UIEnter" },
	{ "vim-denops/denops.vim", event = "UIEnter" },
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
		event = "UIEnter",
		config = function()
			require("config.plugins.neoterm").config()
		end,
	},
	{
		"linty-org/key-menu.nvim",
		event = "UIEnter",
	},
	{
		"numToStr/Comment.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.comment").config()
		end,
	},
	{ "sindrets/diffview.nvim", event = "UIEnter" },
	{ "plasticboy/vim-markdown", event = "UIEnter" },
	{ "hashivim/vim-terraform", event = "UIEnter" },
	{ "dag/vim-fish", event = "UIEnter" },
	{ "skanehira/getpr.vim", event = "UIEnter" },
	{
		"luochen1990/rainbow",
		event = "UIEnter",
		config = function()
			require("config.plugins.rainbow").config()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.indent-blankline").config()
		end,
	},
	{
		"notomo/reacher.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.reacher").config()
		end,
	},
	{
		"eiji03aero/quick-notes",
		event = "UIEnter",
		config = function()
			require("config.plugins.quick-notes").config()
		end,
	},
	{
		"simeji/winresizer",
		event = "UIEnter",
		config = function()
			require("config.plugins.winresizer").config()
		end,
	},
	{
		"fedepujol/move.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.move").config()
		end,
	},
	{
		"rhysd/conflict-marker.vim",
		event = "UIEnter",
		config = function()
			require("config.plugins.conflict-marker").config()
		end,
	},
	{
		"heavenshell/vim-pydocstring",
		event = "UIEnter",
		config = function()
			require("config.plugins.vim-pydocstring").config()
		end,
	},
	{
		"kana/vim-altercmd",
		event = "UIEnter",
		config = function()
			require("config.plugins.vim-altercmd").config()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.plugins.todo-comments").config()
		end,
	},
	{ "dkarter/bullets.vim", ft = "markdown" },
	{
		"folke/noice.nvim",
		event = "UIEnter",
		config = function()
			require("config.plugins.noice").config()
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"tversteeg/registers.nvim",
		name = "registers",
		config = function()
			require("config.plugins.registers").config()
		end,
		cmd = "Registers",
	},
}, {
	defaults = { lazy = true },
	-- debug = true,
})
