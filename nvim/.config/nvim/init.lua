vim.g.mapleader = " "

-- Load options before plugins so they're available during plugin setup.
require("config.options")

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ import = "plugins" }, require("config.lazy"))

require("config.autocmds")

vim.schedule(function()
    require("config.keymaps")
end)
