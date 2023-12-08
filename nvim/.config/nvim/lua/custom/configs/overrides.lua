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
        enable = false,
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
        -- "flake8",
        "isort",
        -- "mypy",
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

M.nvimtree = {
    -- git support in nvimtree
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

M.gitsigns = {
    -- show gitsigns above all else
    -- https://github.com/lewis6991/gitsigns.nvim/issues/95
    sign_priority = 9999,
}

return M
