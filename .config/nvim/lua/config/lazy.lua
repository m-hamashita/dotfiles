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
	{ "vim-scripts/wombat256.vim", lazy = false },
	{ "sainnhe/everforest", lazy = false },
	{ "franbach/miramare", lazy = false },
	{ "jnurmine/Zenburn", lazy = false },
	{ "ghifarit53/tokyonight-vim", lazy = false },
	{ "novasenco/vulpo", lazy = false },
	{ "raphamorim/lucario", lazy = false },
	{ "bluz71/vim-moonfly-colors", lazy = false },
	{ "sonph/onehalf", lazy = false },
	{ "savq/melange", lazy = false },
	{ "kyoh86/momiji", lazy = false },
	{
		"machakann/vim-highlightedyank",
		event = "VimEnter",
		config = require("config.plugins.vim-highlightedyank").config(),
	},
	-- {
	--     "phaazon/hop.nvim",
	--     branch = "v2",
	--     config = function()
	--         require("config.plugins.hop").config()
	--     end,
	-- },
	{
		-- file explorer
		"lambdalisue/fern.vim",
		event = "VimEnter",
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
		event = "VimEnter",
		dependencies = {
			"vim-denops/denops.vim",
		},
	},
	{ "machakann/vim-sandwich", event = "VimEnter" },
	{ "tpope/vim-surround", event = "VimEnter" },
	{
		"gelguy/wilder.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.wilder").config()
		end,
	},
	{
		-- support open new tab
		"lambdalisue/guise.vim",
		event = "VimEnter",
		dependencies = {
			"vim-denops/denops.vim",
		},
	},
	{
		"Shougo/deol.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.deol").config()
		end,
	},
	{ "williamboman/mason.nvim" },
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
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
		event = "VimEnter",
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
		event = "VimEnter",
		config = function()
			require("config.plugins.null-ls").config()
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.lsp-inlayhints").config()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VimEnter",
		config = function()
			require("config.plugins.nvim-cmp").config()
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", event = "VimEnter" },
	{ "hrsh7th/vim-vsnip", event = "VimEnter" },
	{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.lualine").config()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		event = "VimEnter",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("config.plugins.rust-tools").config()
		end,
	},
	{ "kyazdani42/nvim-web-devicons", event = "VimEnter" },
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
		},
		config = function()
			require("config.plugins.telescope").config()
		end,
	},
	{ "dstein64/vim-startuptime", event = "VimEnter" },
	{ "tpope/vim-rhubarb", event = "VimEnter" },
	{ "tpope/vim-fugitive", event = "VimEnter" },
	{ "airblade/vim-gitgutter", event = "VimEnter" },
	{
		"Maan2003/lsp_lines.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.lsp_lines").config()
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{ "vijaymarupudi/nvim-fzf", event = "VimEnter" },
	{ "vim-denops/denops.vim", event = "VimEnter" },
	{
		"nvim-treesitter/nvim-treesitter",
		-- https://discourse.nixos.org/t/cant-get-nvim-treesitter-neovim-plugin-to-work-properly/21368
		commit = "501db14",
		config = function()
			require("config.plugins.nvim-treesitter").config()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		-- if lazy, caw.vim's uncomment is not working
		lazy = false,
	},
	{
		"kassio/neoterm",
		event = "VimEnter",
		config = function()
			require("config.plugins.neoterm").config()
		end,
	},
	{
		"linty-org/key-menu.nvim",
		event = "VimEnter",
	},
	{
		"tyru/caw.vim",
		event = "VimEnter",
		config = function()
			require("config.plugins.caw").config()
		end,
	},
	{ "sindrets/diffview.nvim", event = "VimEnter" },
	{ "plasticboy/vim-markdown", event = "VimEnter" },
	{ "hashivim/vim-terraform", event = "VimEnter" },
	{ "dag/vim-fish", event = "VimEnter" },
	{ "skanehira/getpr.vim", event = "VimEnter" },
	{
		"luochen1990/rainbow",
		event = "VimEnter",
		config = function()
			require("config.plugins.rainbow").config()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.indent-blankline").config()
		end,
	},
	{
		"notomo/reacher.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.reacher").config()
		end,
	},
	{
		"eiji03aero/quick-notes",
		event = "VimEnter",
		config = function()
			require("config.plugins.quick-notes").config()
		end,
	},
	{
		"simeji/winresizer",
		event = "VimEnter",
		config = function()
			require("config.plugins.winresizer").config()
		end,
	},
	{
		"fedepujol/move.nvim",
		event = "VimEnter",
		config = function()
			require("config.plugins.move").config()
		end,
	},
	{
		"rhysd/conflict-marker.vim",
		event = "VimEnter",
		config = function()
			require("config.plugins.conflict-marker").config()
		end,
	},
	{
		"heavenshell/vim-pydocstring",
		event = "VimEnter",
		config = function()
			require("config.plugins.vim-pydocstring").config()
		end,
	},
	{
		"kana/vim-altercmd",
		event = "VimEnter",
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
		event = "VimEnter",
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
}, {
	defaults = { lazy = true },
	-- debug = true,
})
