local overrides = require("custom.configs.overrides")

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
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
        cmd = { "NvimTreeFindFile" },
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                    follow = true,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                    file_ignore_patterns = { "node_modules", ".git" },
                },
                buffers = {
                    show_all_buffers = true,
                    show_lastused = true,
                    mappings = {
                        i = {
                            ["<C-x>"] = "delete_buffer",
                        },
                        n = {
                            ["dd"] = "delete_buffer",
                        },
                    },
                },
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
    },

    {
        "folke/which-key.nvim",
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
        lazy = false,
        branch = "dev",
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
}

return plugins
