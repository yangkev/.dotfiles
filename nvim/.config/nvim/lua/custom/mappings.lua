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
        ["<leader>f"] = "",
        ["<leader>h"] = "",
        ["<leader>ff"] = "",
        ["<leader>fb"] = "",
        ["<leader>fo"] = "",
        ["<leader>fa"] = "",
        ["<leader>fw"] = "",
        ["<leader>ca"] = "",
        ["<C-s>"] = "",
        ["<C-c>"] = "",
        ["<leader>b"] = "",
        ["<tab>"] = "",
        ["<S-tab>"] = "",
        ["<leader>x"] = "",
        ["]c"] = "",
        ["[c"] = "",
        ["<leader>n"] = "",
        ["<leader>rn"] = "",
    },
}

M.general = {
    n = {
        ["<leader>cd"] = { "<cmd> cd %:h <CR> :pwd <CR>", "Change cwd to current file" },
        ["//"] = { ":nohlsearch <CR>" },
        ["gp"] = { "`[v`]", "Highlight previously pasted text" },
        -- Don't move when searching current word
        -- https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
        ["*"] = { ":keepjumps normal! mi*`i <CR>" },
        ["<C-d>"] = { "<C-d>zz" },
        ["<C-u>"] = { "<C-u>zz" },
        -- yank buffer's file path into unnmaed register
        ["cp"] = { ':let @" = expand("%")<CR>' },
    },
    v = {
        [">"] = { ">gv", "indent" },
    },

    c = {
        -- Force saving files that require root permission
        ["w!!"] = { "w !sudo tee > /dev/null %" },
    },
}

M.telescope = {
    plugin = true,

    n = {
        ["<leader>t"] = {
            function()
                require("telescope.builtin").builtin()
            end,
            "Telescope",
        },
        ["<leader>zf"] = {
            function()
                require("telescope.builtin").find_files()
            end,
            "Files",
        },
        ["<leader>zb"] = {
            function()
                require("telescope.builtin").buffers()
            end,
            "Buffers",
        },
        ["<leader>bz"] = {
            function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end,
            "Find in current buffer",
        },
        ["<leader>zo"] = {
            function()
                require("telescope.builtin").vim_options()
            end,
            "Vim Options",
        },
        ["<leader>gs"] = {
            function()
                require("telescope.builtin").grep_string()
            end,
            "Grep current word",
        },
        ["<leader>ju"] = {
            function()
                require("telescope.builtin").jumplist()
            end,
            "Jumplist",
        },
        ["<leader>ts"] = {
            function()
                require("telescope.builtin").treesitter()
            end,
            "Treesitter",
        },
        ["<leader>tr"] = {
            function()
                require("telescope.builtin").resume()
            end,
            "Resume",
        },
        -- LSP mappings, these overwrite NvChad defaults to use telescope instead of buffer
        ["gd"] = {
            function()
                require("telescope.builtin").lsp_definitions()
            end,
            "LSP Definitions",
        },
        ["gr"] = {
            function()
                require("telescope.builtin").lsp_references()
            end,
            "LSP References",
        },
        ["<leader>ic"] = {
            function()
                require("telescope.builtin").lsp_incoming_calls()
            end,
            "LSP Incoming Calls",
        },
        ["<leader>oc"] = {
            function()
                require("telescope.builtin").lsp_outgoing_calls()
            end,
            "LSP Outgoing Calls",
        },
        ["<leader>td"] = {
            function()
                require("telescope.builtin").lsp_type_definitions()
            end,
            "LSP Type Definition",
        },
        ["<leader>ep"] = { "<cmd> Easypick <CR>", "Open Easypick" },
        ["<leader>zg"] = {
            function()
                require("telescope.builtin").grep_string({
                    shorten_path = true,
                    word_match = "-w",
                    only_sort_text = true,
                    search = "",
                    disable_coordinates = true,
                    grep_open_files = true,
                })
            end,
            "Grep open files (buffers)",
        },
    },
}

M.fzf_lua = {
    n = {
        ["<C-p>"] = { "<cmd>lua require('fzf-lua').grep_project()<CR>", "Live grep" },
        ["<leader>fb"] = { "<cmd>lua require('fzf-lua').buffers()<CR>", "fzf buffers" },
        -- ["<leader>fw"] = { "<cmd>lua require('fzf-lua').grep_cword()<CR>", "fzf current word"},
        ["<leader>fr"] = { "<cmd>lua require('fzf-lua').resume()<CR>", "Resume last fzf-lua" },
    },
}

M.nvimtree = {
    plugin = true,
    n = {
        ["<leader>nf"] = { "<cmd> NvimTreeFindFile <CR>", "Find current file in nvimtree" },
        ["<leader>nt"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
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

M.diffview = {
    n = {
        ["<leader>dv"] = { ":DiffviewOpen ", "Open Diffview interactive" },
        ["<leader>dvm"] = { "<cmd> :DiffviewOpen origin/master..HEAD <CR>", "Open Diffview with origin/master" },
        ["<leader>dvc"] = { "<cmd> :DiffviewClose <CR>", "CLose Diffview" },
    },
}

M.gitlinker = {
    n = {
        -- Open line in browser
        ["<leader>gb"] = {
            '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
            opts = { silent = true },
        },
        -- Copy repo base url
        ["<leader>gY"] = { '<cmd>lua require"gitlinker".get_repo_url()<cr>', opts = { silent = true } },
        -- Open repo base url in browser
        ["<leader>gB"] = {
            '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
            opts = { silent = true },
        },
    },
    v = {
        -- Open selected line(s) in browser
        ["<leader>gb"] = {
            '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
            opts = {},
        },
    },
}

return M
