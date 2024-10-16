require("nvchad.mappings")

-- Disable mappings
local nomap = vim.keymap.del
nomap("n", "<tab>")
nomap("n", "<leader>rn")
nomap("n", "<leader>h")

-- add yours here

local map = vim.keymap.set

-- General mappings
map("n", "<leader>cd", "<cmd> cd %:h <CR> :pwd <CR>", { desc = "Change cwd to current file" })
map("n", "//", ":nohlsearch <CR>")
map("n", "gp", "`[v`]", { desc = "Highlight previously pasted text" })
-- Don't move when searching current word
-- https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
map("n", "*", ":keepjumps normal! mi*`i <CR>")
-- yank buffer's file path into unnmaed register
map("n", "cp", ':let @" = expand("%")<CR>')
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

-- Telescope mappings
map("n", "<leader>t", function()
    require("telescope.builtin").builtin()
end, { desc = "Telescope" })
map("n", "<leader>zf", function()
    require("telescope.builtin").find_files()
end, { desc = "Files" })
map("n", "<leader>zb", function()
    require("telescope.builtin").buffers()
end, { desc = "Buffers" })
map("n", "<leader>bz", function()
    require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Find in current buffer" })
map("n", "<leader>zo", function()
    require("telescope.builtin").vim_options()
end, { desc = "Vim Options" })
map("n", "<leader>gs", function()
    require("telescope.builtin").grep_string()
end, { desc = "Grep current word" })
map("n", "<leader>ju", function()
    require("telescope.builtin").jumplist()
end, { desc = "Jumplist" })
map("n", "<leader>ts", function()
    require("telescope.builtin").treesitter()
end, { desc = "Treesitter" })
map("n", "<leader>tr", function()
    require("telescope.builtin").resume()
end, { desc = "Resume" })
-- LSP mappings, these overwrite NvChad defaults to use telescope instead of buffer
map("n", "gd", function()
    require("telescope.builtin").lsp_definitions()
end, { desc = "LSP Definitions" })
map("n", "<leader>ic", function()
    require("telescope.builtin").lsp_incoming_calls()
end, { desc = "LSP Incoming Calls" })
map("n", "<leader>oc", function()
    require("telescope.builtin").lsp_outgoing_calls()
end, { desc = "LSP Outgoing Calls" })
map("n", "<leader>td", function()
    require("telescope.builtin").lsp_type_definitions()
end, { desc = "LSP Type Definition" })
map("n", "<leader>ds", function()
    require("telescope.builtin").lsp_document_symbols()
end, { desc = "LSP Document Symbols" })
map("n", "<leader>ws", function()
    require("telescope.builtin").lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })
map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end, { desc = "LSP Code Action" })

map("n", "<leader>ep", "<cmd> Easypick <CR>", { desc = "Open Easypick" })
map("n", "<leader>zg", function()
    require("telescope.builtin").live_grep({
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = "",
        disable_coordinates = true,
        -- grep_open_files = true,
    })
end, { desc = "Grep open files (buffers)" })

-- fzf-lua mappings
map(
    "n",
    "<C-p>",
    "<cmd>lua require('fzf-lua').grep_project({ fzf_opts = { ['--nth'] = false } })<CR>",
    { desc = "Live grep" }
)
-- map("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", {desc= "fzf buffers" },
map("n", "<leader>fw", "<cmd>lua require('fzf-lua').grep_cword()<CR>", { desc = "fzf current word" })
map("n", "<leader>fr", "<cmd>lua require('fzf-lua').resume()<CR>", { desc = "Resume last fzf-lua" })

-- nvim-tree mappings
map("n", "<leader>nf", "<cmd> NvimTreeFindFile <CR>", { desc = "Find current file in nvimtree" })
map("n", "<leader>nt", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

-- diffview mappings
map("n", "<leader>dv", ":DiffviewOpen ", { desc = "Open Diffview interactive" })
map("n", "<leader>dvm", "<cmd> :DiffviewOpen origin/master..HEAD <CR>", { desc = "Open Diffview with origin/master" })
map("n", "<leader>dvc", "<cmd> :DiffviewClose <CR>", { desc = "Close Diffview" })

-- gitlinker
map(
    "n",
    "<leader>gb",
    '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { desc = "Open line in browser" }
)
map("n", "<leader>gY", '<cmd>lua require"gitlinker".get_repo_url()<cr>', { desc = "Copy repo base url" })
map(
    "n",
    "<leader>gB",
    '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { desc = "Open repo base url in browser" }
)
map(
    "v",
    "<leader>gb",
    '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { desc = "Open selected line(s) in browser" }
)

-- python_copy_reference mappings
map("n", "<leader>rd", "<cmd> :PythonCopyReferenceDotted <cr>", { desc = "Copy Python Reference Dotted" })
map("n", "<leader>rp", "<cmd> :PythonCopyReferencePytest <cr>", { desc = "Copy Python Reference Pytest" })

-- coverage mappings
map("n", "<leader>ct", function()
    require("coverage").toggle()
end, { desc = "Coverage toggle" })
map("n", "]cn", function()
    require("coverage").jump_next("uncovered")
end, { desc = "Coverage jump to next uncovered" })
map("n", "]cp", function()
    require("coverage").jump_prev("uncovered")
end, { desc = "Coverage jump to prev uncovered" })
