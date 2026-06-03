return {
    {
        -- Colorscheme follows tinty: reads ~/.local/share/tinted-theming/tinty/
        -- current_scheme and live-reloads when `tinty apply` rewrites it.
        "tinted-theming/tinted-nvim",
        lazy = false,
        priority = 1000,
        opts = {
            default_scheme = "base16-gruvbox-dark-medium", -- fallback only
            selector = {
                enabled = true,
                mode = "file",
                path = "~/.local/share/tinted-theming/tinty/current_scheme",
                watch = true,
            },
            highlights = { integrations = { lualine = true } },
        },
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        opts = {
            options = {
                -- "auto" derives lualine colors from the active colorscheme's
                -- highlight groups (set up by tinted-nvim's lualine integration),
                -- so it follows tinty. The named "base16" theme would require the
                -- separate RRethy/nvim-base16 plugin, which we don't use.
                theme = "auto",
                globalstatus = false,
                section_separators = "",
                component_separators = "|",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = {
                    "branch",
                    "diff",
                    function()
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if #clients == 0 then
                            return ""
                        end
                        local names = {}
                        for _, client in ipairs(clients) do
                            names[#names + 1] = client.name
                        end
                        return " " .. table.concat(names, ",")
                    end,
                },
                lualine_x = { "diagnostics" },
                lualine_y = {
                    function()
                        return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
                    end,
                },
                lualine_z = { "%m" },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
