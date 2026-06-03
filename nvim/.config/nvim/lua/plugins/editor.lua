return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            picker = {
                enabled = true,
                ui_select = true,
                sources = {
                    buffers = { sort_mru = true },
                    files = {
                        hidden = false,
                        exclude = { "test_durations.csv", "*.svg", "*.dot", ".buildkite/*" },
                    },
                },
                win = {
                    input = {
                        keys = {
                            ["<C-p>"] = { "toggle_preview", mode = { "i", "n" } },
                        },
                    },
                },
            },
        },
    },

    {
        "dmtrKovalenko/fff.nvim",
        build = function()
            require("fff.download").download_or_build_binary()
        end,
        lazy = false,
        config = function()
            require("fff").setup({
                layout = {
                    preview_position = "right",
                    preview_size = 0.5,
                    prompt_position = "bottom",
                },
                preview = {
                    enabled = true,
                },
                frecency = { enabled = true },
                history = { enabled = true },
                grep = {
                    smart_case = true,
                    modes = { "plain", "regex", "fuzzy" },
                },
            })
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
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
        cmd = { "NvimTreeFindFile", "NvimTreeFocus" },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "rmagatti/auto-session",
        lazy = false,
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            })
        end,
    },
}
