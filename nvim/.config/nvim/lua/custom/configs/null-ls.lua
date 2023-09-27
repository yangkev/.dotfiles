local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {
    -- code actions
    b.code_actions.proselint,
    b.code_actions.shellcheck,

    -- diagnostics
    b.diagnostics.flake8.with({ extra_args = { "--config", ".flake8" } }),
    b.diagnostics.mypy,
    -- b.diagnostics.ruff,

    b.diagnostics.shellcheck.with({ filetypes = { "sh", "zsh", "bash" } }),

    b.diagnostics.jsonlint,
    b.diagnostics.markdownlint,
    b.diagnostics.misspell,
    b.diagnostics.proselint,
    b.diagnostics.semgrep,
    b.diagnostics.textlint,

    -- formatting
    b.formatting.black,
    b.formatting.isort,

    b.formatting.clang_format,
    b.formatting.jq,
    b.formatting.prettier.with({ filetypes = { "html", "markdown", "css" } }),
    b.formatting.stylua,
}

null_ls.setup({
    debug = true,
    sources = sources,
})
