return {
    {
        "saghen/blink.cmp",
        version = "*", -- use a release tag so the prebuilt fuzzy binary is downloaded (no cargo build)
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
            -- <CR> accepts only when an item is explicitly selected, otherwise inserts a
            -- newline (matches the previous nvim-cmp behavior). Nothing is preselected.
            keymap = { preset = "enter" },

            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
                menu = { auto_show = true },
            },

            -- Replaces nvim_lsp_signature_help source.
            signature = { enabled = true },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            -- Disable completion in vimwiki buffers (matches previous cmp config).
            enabled = function()
                return vim.bo.filetype ~= "vimwiki"
            end,
        },
        opts_extend = { "sources.default" },
    },
}
