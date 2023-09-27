---@type MappingsTable
local M = {}
M.disabled = {
    i = {
        ["<C-b>"] = "",
        ["<C-e>"] = "",
        ["<C-h>"] = "",
        ["<C-l>"] = "",
        ["<C-j>"] = "",
        ["<C-k>"] = "",
    },
    n = {
        ["<leader>ff"] = "",
        ["<leader>fb"] = "",
        ["<leader>fo"] = "",
        ["<C-s>"] = "",
        ["<C-c>"] = "",
        ["<leader>b"] = "",
        ["<tab>"] = "",
        ["<S-tab>"] = "",
        ["<leader>x"] = "",
    },
}

M.general = {
    n = {
        ["<leader>cd"] = { "<cmd> cd %:h <CR> :pwd <CR>", "Change cwd to current file" },
    },
    v = {
        [">"] = { ">gv", "indent" },
    },
}

M.telescope = {
    plugin = true,

    n = {
        ["<C-p>"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
        ["<leader>t"] = { "<cmd> Telescope <CR>", "Open Telescope" },
        ["<leader>zf"] = { "<cmd> Telescope find_files <CR>", "Files" },
        ["<leader>zb"] = { "<cmd> Telescope buffers <CR>", "Buffers" },
        ["<leader>bz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
        ["<leader>zo"] = { "<cmd> Telescope vim_options <CR>", "Vim Options" },
        ["<leader>ju"] = { "<cmd> Telescope jumplist <CR>", "Jumplist" },
    },
}

M.nvimtree = {
    plugin = true,
    n = {
        ["<leader>nf"] = { "<cmd> NvimTreeFindFile <CR>", "Find current file in nvimtree" },
    },
}

M.gitsigns = {
    n = {
        ["]h"] = {
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to next hunk",
            opts = { expr = true },
        },

        ["[h"] = {
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to prev hunk",
            opts = { expr = true },
        },

        ["ghu"] = {
            function()
                require("gitsigns").reset_hunk()
            end,
            "Reset hunk",
        },

        ["ghp"] = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "Preview hunk",
        },

        ["ghs"] = {
            function()
                require("gitsigns").stage_hunk()
            end,
            "Stage hunk",
        },

        ["gb"] = {
            function()
                package.loaded.gitsigns.blame_line()
            end,
            "Blame line",
        },
    },
}

return M
