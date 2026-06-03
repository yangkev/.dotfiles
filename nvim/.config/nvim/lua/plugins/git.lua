return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            sign_priority = 100,
            update_debounce = 200,
            max_file_length = 40000,
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next", { target = "all" })
                    end
                end)

                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev", { target = "all" })
                    end
                end)
                -- Actions
                map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Gitsigns Stage Hunk" })
                map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Gitsigns Reset Hunk" })
                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end)
                map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Gitsigns Stage Buffer" })
                map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Gitsigns Undo Stage Hunk" })
                map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Gitsigns Reset Buffer" })
                map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Gitsigns Preview Hunk" })
                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true }, { desc = "Gitsigns Blame Line" })
                end)
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Gitsigns Toggle Blame" })
                map("n", "<leader>hd", gitsigns.diffthis, { desc = "Gitsigns Diff This" })
                -- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
                map("n", "<leader>td", gitsigns.toggle_deleted)
            end,
        },
    },

    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<leader>gy",
                '<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>',
                mode = "n",
                desc = "Copy line URL",
            },
            {
                "<leader>gy",
                '<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>',
                mode = "v",
                desc = "Copy line(s) URL",
            },
            {
                "<leader>gb",
                '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
                mode = "n",
                desc = "Open line in browser",
            },
            {
                "<leader>gb",
                '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
                mode = "v",
                desc = "Open line(s) in browser",
            },
            { "<leader>gY", '<cmd>lua require"gitlinker".get_repo_url()<cr>', mode = "n", desc = "Copy repo base URL" },
            {
                "<leader>gB",
                '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
                mode = "n",
                desc = "Open repo in browser",
            },
        },
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
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gwrite", "Gread", "Gdiffsplit", "Gvdiffsplit", "Gclog", "Gllog" },
    },

    {
        "tpope/vim-rhubarb",
        event = "VeryLazy",
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("diffview").setup()
        end,
    },
}
