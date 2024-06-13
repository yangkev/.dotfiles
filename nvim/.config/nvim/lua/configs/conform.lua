local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "autoflake", "isort", "black" },
    },

    format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
