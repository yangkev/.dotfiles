return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()

            -- Highlighting is enabled per-buffer by the FileType autocmd in
            -- config/autocmds.lua (`vim.treesitter.start()`); indentation is left off.
            require("nvim-treesitter").install({
                "c",
                "css",
                "csv",
                "diff",
                "elixir",
                "git_config",
                "git_rebase",
                "gitattributes",
                "gitignore",
                "go",
                "html",
                "ini",
                "javascript",
                "json",
                "lua",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "terraform",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            })
        end,
    },
}
