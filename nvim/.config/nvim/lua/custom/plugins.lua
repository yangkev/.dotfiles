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
}

return plugins
