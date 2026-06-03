return {
    {
        "neovim/nvim-lspconfig",
        -- Load eagerly (not on BufReadPre). vim.lsp.enable() registers the FileType
        -- autocmds that start servers; those must exist BEFORE auto-session's VimEnter
        -- restore fires FileType for the restored buffer, otherwise the server never
        -- attaches until a manual :e re-fires FileType.
        lazy = false,
        -- mason.nvim must load first: mason.setup() prepends ~/.local/share/nvim/mason/bin
        -- to PATH, which is where the server executables live. Without it on PATH before
        -- vim.lsp.enable() runs, no client can spawn.
        dependencies = { "saghen/blink.cmp", "mason-org/mason.nvim" },
        config = function()
            -- Buffer-local LSP keymaps, set when a server attaches (the idiomatic
            -- Neovim 0.11+ LspAttach pattern).
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
                callback = function(args)
                    local bufnr = args.buf
                    local function map(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
                    end

                    -- Override the built-in `grr` to use the Snacks picker (nicer than the
                    -- default quickfix list). Reusing `grr` keeps Neovim's native references
                    -- mnemonic and avoids a `gr`-prefix timeout clash with grn/gra/gri/grt.
                    map("grr", function()
                        Snacks.picker.lsp_references()
                    end, "LSP References")
                    map("<leader>rn", vim.lsp.buf.rename, "LSP Rename")
                    map("K", vim.lsp.buf.hover, "LSP Hover")
                    map("gl", vim.diagnostic.open_float, "Diagnostic Float")
                end,
            })

            -- Completion capabilities applied to every server.
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Per-server settings live in `after/lsp/<name>.lua` and are merged automatically.
            local servers = { "html", "cssls", "pyright", "terraformls", "vtsls", "ruff", "lua_ls" }
            vim.lsp.enable(servers)

            vim.diagnostic.config({
                underline = true,
                virtual_text = false,
                severity_sort = true,
                update_in_insert = false,
                float = {
                    source = "if_many",
                },
            })
        end,
    },

    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = {},
    },

    {
        -- mason.nvim itself has no `ensure_installed`; this installer consumes
        -- the list and installs LSPs + formatters/linters on startup. mason.setup()
        -- must run first (it registers the package registry), so mason is a dependency.
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        event = "VeryLazy",
        opts = {
            ensure_installed = {
                -- lua stuff
                "lua-language-server",
                "stylua",

                -- web dev stuff
                "css-lsp",
                "html-lsp",
                "vtsls",
                "prettier",

                -- python
                "black",
                "autoflake",
                -- "flake8",
                "isort",
                "mypy",
                "pyright",
                "ruff",

                -- shell
                "shellcheck",

                -- sql
                "sql-formatter",

                -- terraform
                "terraform-ls",

                -- general/text
                "jsonlint",
                "jq",
                "markdownlint",
                "proselint",
                "semgrep",
                "textlint",
            },
        },
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
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
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = { "mypy" },
            }

            vim.api.nvim_create_autocmd("BufWritePost", {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
