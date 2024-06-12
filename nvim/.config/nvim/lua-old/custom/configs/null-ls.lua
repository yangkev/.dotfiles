local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
    -- code actions
    b.code_actions.proselint,
    b.code_actions.shellcheck,

    -- diagnostics
    b.diagnostics.flake8.with({ extra_args = { "--config", ".flake8" } }),
    -- b.diagnostics.mypy,
    -- b.diagnostics.ruff,

    b.diagnostics.shellcheck.with({ filetypes = { "sh", "zsh", "bash" } }),

    b.diagnostics.jsonlint,
    b.diagnostics.markdownlint,
    b.diagnostics.misspell,
    b.diagnostics.proselint,
    -- b.diagnostics.semgrep,
    b.diagnostics.textlint,

    -- formatting
    b.formatting.black.with({
        extra_args = {
            "--target-version",
            "py310",
        },
    }),
    b.formatting.autoflake.with({
        extra_args = {
            "--in-place",
            "--remove-all-unused-imports",
        },
    }),
    b.formatting.isort.with({
        extra_args = {
            "--profile",
            "black",
        },
    }),
    b.formatting.sql_formatter.with({
        extra_args = {
            "--language",
            "postgresql",
        },
    }),

    b.formatting.clang_format,
    b.formatting.jq,
    b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }),
    b.formatting.stylua,
}

null_ls.setup({
    -- debug = true,
    sources = sources,
})
