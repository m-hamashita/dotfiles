local M = {}

function M.config()
    vim.g.coc_global_extensions = {
        "coc-json",
        "coc-pairs",
        "coc-clangd",
        "coc-tsserver",
        "coc-prettier",
        "coc-eslint",
        "coc-yaml",
        "coc-git",
        "coc-fzf-preview",
        "coc-docker",
        "coc-pyright",
        "coc-go",
        "coc-rust-analyzer",
        "coc-lua",
    }
    vim.keymap.set("n", "gw", "<Plug>(coc-git-chunkinfo)", {})
    vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {})
    vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {})
    vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {})
    vim.keymap.set("n", "gr", "<Plug>(coc-references)", {})
    vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {})
end

return M
