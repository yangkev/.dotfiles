local M = {}

M.treesitter = {
    ensure_installed = {
        "c",
        "css",
        "csv",
        "diff",
        "elixir",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitignore",
        "go",
        "html",
        "ini",
        "javascript",
        "json",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
    indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
    },
}

M.mason = {
    ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "prettier",

        -- python
        "black",
        "flake8",
        "isort",
        "mypy",
        "pyright",
        "ruff",

        -- shell
        "shellcheck",

        -- terraform
        "terraform-ls",

        -- general/text
        "jsonlint",
        "jq",
        "markdownlint",
        "misspell",
        "proselint",
        "semgrep",
        "textlint",
    },
}

-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true,
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true,
            },
        },
    },
}

return M
