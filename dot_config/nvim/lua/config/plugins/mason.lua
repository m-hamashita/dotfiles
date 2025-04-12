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
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- substitued by lspsaga
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- substituted by lspsaga
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        -- vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>") --substitued by lspsaga
    end
    lspconfig.setup_handlers({
        function(server_name)
            if server_name == "sumneko_lua" then
                nvim_lsp[server_name].setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim", "hs" },
                            },
                        },
                    },
                    on_attach = on_attach,
                })
            elseif server_name == "gopls" then -- gopls is the language server for Go
                nvim_lsp[server_name].setup({
                    settings = {
                        gopls = {
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        },
                    },
                    on_attach = on_attach,
                })
            elseif server_name == "clangd" then
                -- if offsetEncoding not set, messages: "warning: multiple different client offset_encodings detected for buffer, this is not supported yet."
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities.offsetEncoding = { "utf-16" }
                nvim_lsp[server_name].setup({
                    capabilities = capabilities,
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
