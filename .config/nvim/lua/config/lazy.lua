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
    {
        "machakann/vim-highlightedyank",
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
    {
        "simrat39/rust-tools.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
    "kyazdani42/nvim-web-devicons",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        config = function()
            require("config.plugins.telescope")
        end,
    },
    "dstein64/vim-startuptime",
    "tpope/vim-rhubarb",
    "tpope/vim-fugitive",
    "airblade/vim-gitgutter",
    -- {
    --     "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --     config = function()
    --         require("config.plugins.lsp_lines").setup()
    --     end,
    --     dependencies = { "neovim/nvim-lspconfig" },
    -- },
    "vijaymarupudi/nvim-fzf",
    "vim-denops/denops.vim",
    {
        "nvim-treesitter/nvim-treesitter",
        -- https://discourse.nixos.org/t/cant-get-nvim-treesitter-neovim-plugin-to-work-properly/21368
        commit = "501db1459a7a46cb0766b3c56e9a6904bbcbcc97",
        config = function()
            require("config.plugins.nvim-treesitter")
        end,
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
        "kassio/neoterm",
        config = function()
            require("config.plugins.neoterm")
        end,
    },
    {
        "neoclide/coc.nvim",
        branch = "release",
        run = "yarn install --frozen-lockfile",
        config = function()
            require("config.plugins.coc")
        end,
    },
    "linty-org/key-menu.nvim",
    {
        "tyru/caw.vim",
        config = function()
            require("config.plugins.caw")
        end,
    },
    "sindrets/diffview.nvim",
    "plasticboy/vim-markdown",
    "hashivim/vim-terraform",
    "dag/vim-fish",
    "skanehira/getpr.vim",
    {
        "luochen1990/rainbow",
        config = function()
            require("config.plugins.rainbow")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("config.plugins.indent-blankline")
        end,
    },
    {
        "notomo/reacher.nvim",
        config = function()
            require("config.plugins.reacher")
        end,
    },
    {
        "eiji03aero/quick-notes",
        config = function()
            require("config.plugins.quick-notes")
        end,
    },
    {
        "simeji/winresizer",
        config = function()
            require("config.plugins.winresizer")
        end,
    },
    {
        "fedepujol/move.nvim",
        config = function()
            require("config.plugins.move")
        end,
    },
    {
        "rhysd/conflict-marker.vim",
        config = function()
            require("config.plugins.conflict-marker")
        end,
    },
    {
        "heavenshell/vim-pydocstring",
        config = function()
            require("config.plugins.vim-pydocstring")
        end,
    },
    {
        "kana/vim-altercmd",
        config = function()
            require("config.plugins.vim-altercmd")
        end,
    },
}, {
    defaults = { lazy = false },
    debug = true,
})
