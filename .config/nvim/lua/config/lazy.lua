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

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

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
    {
        "machakann/vim-highlightedyank",
        config = require("config.plugins.vim-highlightedyank").config(),
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
        config = function()
            require("config.plugins.hop").config()
        end,
    },
    {
        -- file explorer
        "lambdalisue/fern.vim",
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
        dependencies = {
            "vim-denops/denops.vim",
        },
    },
    "machakann/vim-sandwich",
    "tpope/vim-surround",
    {
        "gelguy/wilder.nvim",
        config = function()
            require("config.plugins.wilder").config()
        end,
    },
    {
        -- support open new tab
        "lambdalisue/guise.vim",
        dependencies = {
            "vim-denops/denops.vim",
        },
    },
    {
        "Shougo/deol.nvim",
        config = function()
            require("config.plugins.deol").config()
        end,
    },
    "williamboman/mason.nvim",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("config.plugins.mason").config()
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason.nvim",
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("config.plugins.null-ls").config()
        end,
    },
    {
        "lvimuser/lsp-inlayhints.nvim",
        config = function()
            require("config.plugins.lsp-inlayhints")
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("config.plugins.nvim-cmp")
        end,
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/vim-vsnip",
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("config.plugins.lualine")
        end,
    },
    "mfussenegger/nvim-dap",
    "simrat39/rust-tools.nvim",
    "kyazdani42/nvim-web-devicons",
}, {
    defaults = { lazy = false },
})