---@type NvPluginSpec[]
local plugins = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("custom.configs.null-ls")
                end,
            },
        },
        config = function()
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
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
                "black@22.3.0",
                "autoflake",
                -- "flake8",
                "isort",
                -- "mypy",
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
                "misspell",
                "proselint",
                "semgrep",
                "textlint",
            },
        },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        highlight = {
            enable = true,
        },
        opts = {
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
                "vimdoc",
                "yaml",
            },
            indent = {
                enable = false,
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            -- git support in nvimtree
            git = {
                enable = true,
            },

            filters = {
                git_ignored = false,
            },

            view = {
                width = {
                    min = 30,
                    max = -1,
                    padding = 1,
                },
            },

            update_focused_file = {
                enable = false,
            },

            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
        },
        cmd = { "NvimTreeFindFile" },
    },

    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
    },

    {
        "windwp/nvim-autopairs",
        enabled = true,
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                        ["<C-h>"] = "which_key",
                    },
                    n = {
                        ["?"] = require("telescope.actions.layout").toggle_preview,
                        ["<C-h>"] = "which_key",
                    },
                },
                cache_picker = {
                    ignore_empty_prompt = false,
                },
                preview = {
                    hide_on_startup = true, -- hide previewer when picker starts
                },
                file_ignore_patterns = { "test_durations.csv", "%.svg", "%.dot", "^.buildkite/" },
            },
            -- extensions = {
            --     fzf = {
            --         fuzzy = true,
            --         override_generic_sorter = true,
            --         override_file_sorter = true,
            --         case_mode = "smart_case",
            --     },
            -- },
            pickers = {
                find_files = {
                    hidden = true,
                    follow = true,
                    no_ignore = true,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
                buffers = {
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<C-x>"] = "delete_buffer",
                        },
                        n = {
                            ["dd"] = "delete_buffer",
                        },
                    },
                },
                jumplist = {
                    fname_width = 60,
                },
                lsp_document_symbols = {
                    symbol_width = 50,
                    fname_width = 50,
                    symbol_type_width = 15,
                },
                lsp_references = {
                    fname_width = 50,
                },
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
    },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("diffview").setup()
        end,
    },

    {
        "rmagatti/auto-session",
        lazy = false, -- always load auto-session
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            })
        end,
    },

    {
        "vimwiki/vimwiki",
        branch = "dev",
        lazy = false,
        init = function()
            vim.g.vimwiki_list = {
                {
                    syntax = "markdown",
                    ext = ".md",
                    path = "~/wiki/ramp/",
                    auto_toc = 1,
                    auto_tags = 1,
                    list_margin = 0,
                    nested_syntaxes = {
                        python = "python",
                        -- c++ = 'cpp',
                        c = "c",
                        sh = "sh",
                        yaml = "yaml",
                        go = "go",
                        sql = "sql",
                    },
                },
            }
            vim.g.vimwiki_global_ext = 0
            vim.g.vimwiki_hl_cb_checked = 2
            vim.g.markdown_fenced_languages = {
                "sh",
                "bash=sh",
                "css",
                "c",
                "cpp",
                "javascript",
                "js=javascript",
                "json=javascript",
                "make",
                "python",
                "html",
                "vim",
                "go",
            }
        end,
    },

    {
        "axkirillov/easypick.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        init = function()
            local easypick = require("easypick")
            easypick.setup({
                pickers = {
                    -- diff current branch with base_branch and show files that changed with respective diffs in preview
                    {
                        name = "changed_not_staged_files",
                        command = "git diff --name-only",
                        -- command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
                        -- previewer = easypick.previewers.branch_diff({base_branch = base_branch})
                        previewer = easypick.previewers.file_diff(),
                    },
                    -- diff current branch with base_branch and show files that changed with respective diffs in preview
                    {
                        name = "staged_files",
                        command = "git diff --cached --name-only",
                        previewer = easypick.previewers.file_diff(),
                    },

                    -- list files that have conflicts with diffs in preview
                    {
                        name = "conflicts",
                        command = "git diff --name-only --diff-filter=U --relative",
                        previewer = easypick.previewers.file_diff(),
                    },
                },
            })
        end,
    },

    {
        "tpope/vim-fugitive",
        lazy = false,
    },

    {
        "tpope/vim-rhubarb",
        lazy = false,
    },

    {
        "karb94/neoscroll.nvim",
        config = function()
            require("neoscroll").setup()
        end,
    },

    {
        "andythigpen/nvim-coverage",
        cmd = {
            "Coverage",
            "CoverageLoad",
            "CoverageLoadLcov",
            "CoverageShow",
            "CoverageHide",
            "CoverageToggle",
            "CoverageClear",
            "CoverageSummary",
        },
        config = function()
            require("coverage").setup({
                lang = {
                    python = {
                        coverage_file = "/tmp/.coverage",
                    },
                },
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    preview = { default = "bat_native" },
                },
                -- fzf_opts = { ["--ansi"] = false },
                grep = {
                    git_icons = false,
                    file_icons = false,
                    -- add '--hidden' to defaults
                    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
                },
                files = {
                    git_icons = false,
                    file_icons = false,
                },
            })
        end,
    },

    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            require("gitlinker").setup({
                callbacks = {
                    ["github-yangkev"] = function(url_data)
                        url_data.host = "github.com"
                        return require("gitlinker.hosts").get_github_type_url(url_data)
                    end,
                },
                opts = {
                    print_url = false,
                },
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        opts = {
            -- show gitsigns above all else
            -- https://github.com/lewis6991/gitsigns.nvim/issues/95
            sign_priority = 9999,
        },
    },

    -- {
    --     "L3MON4D3/LuaSnip",
    --     enabled = false,
    -- },

    {
        "rafamadriz/friendly-snippets",
        enabled = false,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-cmdline",
        },

        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
            cmp.setup.filetype({ "vimwiki" }, {
                enabled = false,
            })
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },

    {
        "tris203/hawtkeys.nvim",
        cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
        config = true,
    },
    {
        "ranelpadon/python-copy-reference.vim",
        ft = "python",
    },
}
return plugins
