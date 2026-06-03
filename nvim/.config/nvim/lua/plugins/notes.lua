return {
    {
        "vimwiki/vimwiki",
        branch = "dev",
        lazy = false,
        init = function()
            vim.g.vimwiki_list = {
                {
                    syntax = "markdown",
                    ext = ".md",
                    path = "~/wiki/",
                    auto_toc = 1,
                    auto_tags = 1,
                    list_margin = 0,
                    nested_syntaxes = {
                        python = "python",
                        -- c++ = 'cpp',
                        c = "c",
                        sh = "sh",
                        yaml = "yaml",
                        go = "go",
                        sql = "sql",
                    },
                },
            }
            vim.g.vimwiki_global_ext = 0
            vim.g.vimwiki_hl_cb_checked = 2
            vim.g.markdown_fenced_languages = {
                "sh",
                "bash=sh",
                "css",
                "c",
                "cpp",
                "javascript",
                "js=javascript",
                "json=javascript",
                "make",
                "python",
                "html",
                "vim",
                "go",
            }
        end,
    },

    {
        "Vimjas/vim-python-pep8-indent",
        ft = "python",
    },

    {
        "ranelpadon/python-copy-reference.vim",
        ft = "python",
    },

    {
        "brianhuster/live-preview.nvim",
        cmd = { "LivePreview" },
    },
}
