local lint = require("lint")

-- Configure mypy for Python files
lint.linters_by_ft = {
    python = { "mypy" },
}

-- Run linters automatically
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
