local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require("custom.configs.null-ls")
                end,
            },
        },
        config = function()
            require("plugins.configs.lspconfig")
            require("custom.configs.lspconfig")
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
        cmd = { "NvimTreeFindFile" },
    },

    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
                        ["<C-h>"] = "which_key",
                    },
                    n = {
                        ["?"] = require("telescope.actions.layout").toggle_preview,
                        ["<C-h>"] = "which_key",
                    },
                },
                preview = {
                    hide_on_startup = true, -- hide previewer when picker starts
                },
            },
            -- extensions = {
            --     fzf = {
            --         fuzzy = true,
            --         override_generic_sorter = true,
            --         override_file_sorter = true,
            --         case_mode = "smart_case",
            --     },
            -- },
            pickers = {
                find_files = {
                    hidden = true,
                    follow = true,
                },
                live_grep = {
                    additional_args = function()
                        return { "--hidden" }
                    end,
                    file_ignore_patterns = { "node_modules", ".git" },
                },
                buffers = {
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<C-x>"] = "delete_buffer",
                        },
                        n = {
                            ["dd"] = "delete_buffer",
                        },
                    },
                },
                jumplist = {
                    fname_width = 60,
                },
                treesitter = {
                    fname_width = 60,
                },
            },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
    },

    {
        "folke/which-key.nvim",
        enabled = false,
    },

    {
        "max397574/better-escape.nvim",
        event = "InsertEnter",
        config = function()
            require("better_escape").setup()
        end,
    },

    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("diffview").setup()
        end,
    },

    {
        "rmagatti/auto-session",
        lazy = false, -- always load auto-session
        config = function()
            require("auto-session").setup({
                log_level = "error",
                auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            })
        end,
    },

    {
        "vimwiki/vimwiki",
        branch = "dev",
        lazy = false,
        init = function()
            vim.g.vimwiki_list = {
                {
                    syntax = "markdown",
                    ext = ".md",
                    path = "~/wiki/ramp/",
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
        "axkirillov/easypick.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        init = function()
            local easypick = require("easypick")
            easypick.setup({
                pickers = {
                    -- diff current branch with base_branch and show files that changed with respective diffs in preview
                    {
                        name = "changed_files",
                        command = "git diff --name-only",
                        -- command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
                        -- previewer = easypick.previewers.branch_diff({base_branch = base_branch})
                        previewer = easypick.previewers.file_diff(),
                    },

                    -- list files that have conflicts with diffs in preview
                    {
                        name = "conflicts",
                        command = "git diff --name-only --diff-filter=U --relative",
                        previewer = easypick.previewers.file_diff(),
                    },
                },
            })
        end,
    },

    {
        "tpope/vim-fugitive",
        lazy = false,
    },

    {
        "tpope/vim-rhubarb",
        lazy = false,
    },

    -- {
    --     "karb94/neoscroll.nvim",
    --     lazy = false,
    --     config = function()
    --         require('neoscroll').setup()
    --     end
    -- }

    {
        "andythigpen/nvim-coverage",
        cmd = {
            "Coverage",
            "CoverageLoad",
            "CoverageLoadLcov",
            "CoverageShow",
            "CoverageHide",
            "CoverageToggle",
            "CoverageClear",
            "CoverageSummary",
        },
        config = function()
            require("coverage").setup({
                lang = {
                    python = {
                        coverage_file = "/tmp/.coverage",
                    },
                },
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("fzf-lua").setup({
                winopts = {
                    preview = { default = "bat_native" },
                },
                -- fzf_opts = { ["--ansi"] = false },
                grep = {
                    git_icons = false,
                    file_icons = false,
                    -- add '--hidden' to defaults
                    rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
                },
                files = {
                    git_icons = false,
                    file_icons = false,
                },
            })
        end,
    },
}
return plugins
