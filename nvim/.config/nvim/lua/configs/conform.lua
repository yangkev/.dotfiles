local options = {
    formatters = {
        sql_formatter = {
            args = {
                "--language",
                "postgresql",
            },
        },
    },
    formatters_by_ft = {
        lua = { "stylua" },
        python = {
            "ruff_fix",
            "ruff_format",
        },
        json = {
            "jq",
        },
        sql = {
            -- "sqlfluff",
            "sql_formatter",
            -- "sqlfmt",
        },
        yaml = {
            "yamlfmt",
        },
        xml = {
            "xmllint",
        },
    },

    log_level = vim.log.levels.DEBUG,
    format_on_save = {
        timeout_ms = 4000,
        -- lsp_fallback = true,
    },
}

require("conform").setup(options)
