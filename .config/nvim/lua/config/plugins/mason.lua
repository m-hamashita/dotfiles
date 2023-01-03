local M = {}

function M.config()
    local mason = require("mason")
    mason.setup({
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    })
    local nvim_lsp = require("lspconfig")
    local lspconfig = require("mason-lspconfig")
    local on_attach = function(_, bufnr)
        local bufopts = { silent = true, buffer = bufnr }
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gk", vim.lsp.buf.format, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    end
    lspconfig.setup_handlers({
        function(server_name)
            if server_name == "sumneko_lua" then
                nvim_lsp[server_name].setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                    on_attach = on_attach,
                })
            else
                nvim_lsp[server_name].setup({
                    on_attach = on_attach,
                })
            end
        end,
    })
end

return M
