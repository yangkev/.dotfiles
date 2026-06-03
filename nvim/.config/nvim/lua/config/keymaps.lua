local map = vim.keymap.set

-- Close listed buffers that no longer point at real files on disk
local function purge_dead_buffers()
    local deleted = 0

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not vim.bo[buf].modified then
            local name = vim.api.nvim_buf_get_name(buf)
            local buftype = vim.bo[buf].buftype
            local is_real_file = buftype == "" and name ~= "" and vim.uv.fs_stat(name)

            if not is_real_file then
                vim.api.nvim_buf_delete(buf, { force = true })
                deleted = deleted + 1
            end
        end
    end

    local title = "Buffers"

    if deleted > 0 then
        vim.notify(
            ("Purged %d dead buffer%s"):format(deleted, deleted == 1 and "" or "s"),
            vim.log.levels.INFO,
            { title = title }
        )
    else
        vim.notify("No dead buffers found", vim.log.levels.INFO, { title = title })
    end
end

vim.api.nvim_create_user_command(
    "PurgeDeadBuffers",
    purge_dead_buffers,
    { desc = "Close listed buffers that no longer have files on disk" }
)

map("n", "<leader>bp", purge_dead_buffers, { desc = "Purge dead buffers" })

-- Better j/k navigation for wrapped lines, moves by visual lines when count isn't provided
map("n", "j", "v:count ? 'j' : 'gj'", { expr = true })
map("n", "k", "v:count ? 'k' : 'gk'", { expr = true })

-- General mappings
map("n", "<leader>cd", "<cmd> cd %:h <CR> :pwd <CR>", { desc = "Change cwd to current file" })
map("n", "//", ":nohlsearch <CR>")
map("n", "gp", "`[v`]", { desc = "Highlight previously pasted text" })
-- Don't move when searching current word
-- https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
map("n", "*", ":keepjumps normal! mi*`i <CR>")
-- yank buffer's file path into unnmaed register
map("n", "cp", ':let @+ = expand("%")<CR>')
map("v", ">", ">gv", { desc = "indent" })

-- Force saving files that require root permission
map("c", "w!!", "w !sudo tee > /dev/null %")

-- LspConfig mappings
map("n", "<leader>dt", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle LSP Diagnostics" })
map("n", "<leader>do", function()
    vim.diagnostic.show()
end, { desc = "show lsp diagnostic" })
map("n", "<leader>lf", function()
    vim.diagnostic.open_float()
end, { desc = "LSP Diagnostic Open Float" })
map("n", "<leader>fm", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Conform Format" })

-- Picker mappings (Snacks.picker + fff)
map("n", "<leader>t", function()
    Snacks.picker.pickers()
end, { desc = "Pickers" })
map("n", "ff", function()
    require("fff").find_files()
end, { desc = "FFFind files" })
map("n", "<leader>zb", function()
    Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>bz", function()
    Snacks.picker.lines()
end, { desc = "Find in current buffer" })
map("n", "fc", function()
    require("fff").live_grep({ query = vim.fn.expand("<cword>") })
end, { desc = "Search current word (fff)" })
map("n", "<leader>ju", function()
    Snacks.picker.jumps()
end, { desc = "Jumplist" })
map("n", "<leader>ts", function()
    Snacks.picker.treesitter()
end, { desc = "Treesitter" })
map("n", "<leader>tr", function()
    Snacks.picker.resume()
end, { desc = "Resume" })
-- LSP mappings
map("n", "gd", function()
    Snacks.picker.lsp_definitions()
end, { desc = "LSP Definitions" })
map("n", "<leader>ic", function()
    vim.lsp.buf.incoming_calls()
end, { desc = "LSP Incoming Calls" })
map("n", "<leader>oc", function()
    vim.lsp.buf.outgoing_calls()
end, { desc = "LSP Outgoing Calls" })
map("n", "<leader>td", function()
    Snacks.picker.lsp_type_definitions()
end, { desc = "LSP Type Definition" })
map("n", "<leader>ds", function()
    Snacks.picker.lsp_symbols()
end, { desc = "LSP Document Symbols" })
map("n", "<leader>ws", function()
    Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

map("n", "fg", function()
    require("fff").live_grep()
end, { desc = "LiFFFe grep" })
map("n", "fz", function()
    require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
end, { desc = "Live fuzzy grep" })

-- nvim-tree mappings
map("n", "<leader>nf", "<cmd> NvimTreeFindFile <CR>", { desc = "Find current file in nvimtree" })
map("n", "<leader>nt", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

-- diffview mappings
map("n", "<leader>dv", ":DiffviewOpen ", { desc = "Open Diffview interactive" })
map("n", "<leader>dvm", "<cmd> :DiffviewOpen origin/master..HEAD <CR>", { desc = "Open Diffview with origin/master" })
map("n", "<leader>dvc", "<cmd> :DiffviewClose <CR>", { desc = "Close Diffview" })

-- python_copy_reference mappings
map("n", "<leader>rd", "<cmd> :PythonCopyReferenceDotted <cr>", { desc = "Copy Python Reference Dotted" })
map("n", "<leader>rp", "<cmd> :PythonCopyReferencePytest <cr>", { desc = "Copy Python Reference Pytest" })
map("n", "<leader>ri", "<cmd> :PythonCopyReferenceImport <cr>", { desc = "Copy Python Reference Import" })
