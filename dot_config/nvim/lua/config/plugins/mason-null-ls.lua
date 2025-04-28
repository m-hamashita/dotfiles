local M = {}

function M.config()
    local mason_null_ls = require("mason-null-ls")
    local config = {
        -- A list of sources to install if they're not already installed.
        -- This setting has no relation with the `automatic_installation` setting.
        -- ensure_installed = { "stylua", "jq" },
        -- Enable or disable null-ls methods to get set up
        -- This setting is useful if some functionality is handled by other plugins such as `conform` and `nvim-lint`
        methods = {
            diagnostics = true,
            formatting = true,
            code_actions = true,
            completion = true,
            hover = true,
        },
        -- Run `require("null-ls").setup`.
        -- Will automatically install masons tools based on selected sources in `null-ls`.
        -- Can also be an exclusion list.
        -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
        automatic_installation = false,
        -- See [#handlers-usage](#handlers-usage) section
        handlers = nil,
    }
    mason_null_ls.setup(config)
end

return M
