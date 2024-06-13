-- Vimwiki fi.etype specific settings, even though my vimwiki is in markdown
local opt_local = vim.opt_local
opt_local.wrap = true
opt_local.linebreak = true
opt_local.list = false

opt_local.relativenumber = false
opt_local.number = false
opt_local.signcolumn = "no"

vim.diagnostic.enable(false)
