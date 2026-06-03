local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Enable treesitter highlighting per buffer (nvim-treesitter `main` branch no longer
-- enables it for us). pcall guards filetypes without an installed parser.
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Restore last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
