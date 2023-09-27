local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.shiftround = true
opt.smartindent = false
opt.showmatch = true
opt.incsearch = true
opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 8
opt.ttimeoutlen = 10
opt.lazyredraw = true
opt.wildignore = "*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*.aux,*.fdb_latexmk,*.fls,*.gz"
opt.fillchars = opt.fillchars + "diff:/"

-- Reset clipboard behavior to normal since NvChad uses unnamedplus
opt.clipboard = ""
